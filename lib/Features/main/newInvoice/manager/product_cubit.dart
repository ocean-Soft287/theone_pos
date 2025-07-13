import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_state.dart';

import 'package:theonepos/corec/apis/dioHelper.dart';
import 'package:theonepos/corec/apis/encrupt.dart';
import 'package:theonepos/corec/sharde/consts.dart';
import 'package:theonepos/corec/sharde/snackbar_component.dart';
import '../../../../Corec/local/chacheHelper.dart';
import '../../edit_delete_invoice/model/invoice_model.dart';
import '../../home/screen/home_screen.dart';
import '../../edit_delete_invoice/screen/InvoicePrint.dart';
import '../model/product_model.dart';

class ProductViewCubit extends Cubit<ProductState> {
  ProductViewCubit() : super(InitializeProductState()) {
    // Load pattern ID from cache when cubit is created
    loadPatternIDFromCache();
  }
  Map<int, TextEditingController> quantityControllers = {};

  String address = '';
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> fetchAndSendLocation(
    BuildContext context, {
    int retryCount = 0,
  }) async {
    if (retryCount >= 3) {
      showSnackBar(context, 'not_enable_location_service'.tr(), duration: 5);
      Navigator.pop(context);
      return;
    }

    emit(LocationLoading());

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showSnackBar(context, 'enable_location_service'.tr());
        await Future.delayed(const Duration(seconds: 3));
        return fetchAndSendLocation(context, retryCount: retryCount + 1);
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showSnackBar(context, 'enable_location_service'.tr());
          await Future.delayed(const Duration(seconds: 3));
          return fetchAndSendLocation(context, retryCount: retryCount + 1);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showSnackBar(context, 'location_permission_permanently_denied'.tr());
        Navigator.pop(context);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = position.latitude;
      longitude = position.longitude;

      final latSaved = await CacheHelper.saveDouble(
        key: "mylat",
        value: position.latitude,
      );
      final longSaved = await CacheHelper.saveDouble(
        key: "mylong",
        value: position.longitude,
      );
      final x = await CacheHelper.getData(key: "mylong");
      print("longSaved:$x");
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      Placemark place = placemarks.first;

      String address =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      print(address);
      emit(LocationLoaded(latitude, longitude, address));
    } catch (e) {
      await Future.delayed(const Duration(seconds: 3));
      return fetchAndSendLocation(context, retryCount: retryCount + 1);
    }
  }

  List<Map<String, dynamic>> categoryAllList =
      Hive.box(('MainCategory')).values
          .map((value) => Map<String, dynamic>.from(value as Map))
          .toList() ??
      [];

  void getMainCategory() {
    emit(GetCategoryLoadingState());

    DioHelper.getData(url: 'api/Category/GetMainCategory')
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);
          List<Map<String, dynamic>> categoryAllList2 =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          await Hive.box('MainCategory').clear();
          for (var item in categoryAllList2) {
            final box = Hive.box('MainCategory');
            await box.add(item);
          }
          categoryAllList =
              Hive.box(
                'MainCategory',
              ).values.cast<Map<String, dynamic>>().toList();

          getSubCategory(mainCategoryId: categoryAllList[0]["CategoryId"]);
          getProductByCategory(categoryAllList[0]["CategoryId"]);
          emit(GetCategorySuccessState());
        })
        .catchError((error) {
          emit(GetCategoryErrorState());
        });
  }

  List<Map<String, dynamic>> subCategoryList = [];

  Future<void> getSubCategory({required int mainCategoryId}) async {
    emit(GetSubCategoryLoading());
    var box = await Hive.openBox('subCategory');

    try {
      final response = await DioHelper.getData(
        url: 'api/Category/GetCategoryByParentId?Parent=$mainCategoryId',
      );

      if (response.statusCode == 200) {
        final decryptedText = decrypt(response.data, privateKey, publicKey);

        try {
          final parsedData = json.decode(decryptedText);
          if (parsedData is List) {
            subCategoryList =
                parsedData
                    .map((item) => (item as Map).cast<String, dynamic>())
                    .toList();

            box.put(mainCategoryId, subCategoryList);

            emit(GetSubCategorySuccess());
          } else {
            throw const FormatException("Decrypted data is not a list");
          }
        } catch (e) {
          throw FormatException("Invalid JSON after decryption: $e");
        }
      } else {
        if (box.containsKey(mainCategoryId)) {
          subCategoryList =
              (box.get(mainCategoryId) as List<dynamic>)
                  .map((item) => (item as Map).cast<String, dynamic>())
                  .toList();
        } else {}
        emit(GetSubCategoryError());
      }
    } catch (error) {
      if (box.containsKey(mainCategoryId)) {
        subCategoryList =
            (box.get(mainCategoryId) as List<dynamic>)
                .map((item) => (item as Map).cast<String, dynamic>())
                .toList();
      }

      emit(GetSubCategoryError());
    }
  }

  void getProductByCategory(int subCategoryId) async {
    print(subCategoryId);
    emit(GetProductLoadingState());

    var box = await Hive.openBox('products');

    try {
      var response = await DioHelper.getData(
        url:
            'api/Product/GetProductsByCategory?categoryId=$subCategoryId&pageNumber=1&pageSize=100&ACID=${customer?["AccountID"] ?? -1}',
      );

      var item = decrypt(response.data, privateKey, publicKey);
      var newProducts =
          (json.decode(item) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();

      productByIdList = newProducts;

      box.put(subCategoryId, productByIdList);

      emit(GetProductSuccessState());
    } catch (error) {
      print(error.toString());
      if (box.containsKey(subCategoryId)) {
        productByIdList =
            (box.get(subCategoryId) as List<dynamic>)
                .map((item) => (item as Map).cast<String, dynamic>())
                .toList();
      } else {
        productByIdList = [];
      }

      emit(GetProductSuccessState());
    }
  }

  void updateListItem(int index, String newValue) {
    itemList[index]['Quantity'] = newValue;
    emit(ItemUpdatedState());
  }

  List<Map<String, dynamic>> productByIdList = [];

  int changeSelectedItemList = 0;

  void changeSelected({required int changeSelectedItem}) {
    changeSelectedItemList = changeSelectedItem;
    emit(ChangeSelectedItemList());
  }

  int changeCategory = 0;

  void changeCategoryI({required int changeSelectedCategory}) {
    changeCategory = changeSelectedCategory;

    emit(ChangeSelectedCategory());
  }

  int changeSubCategory = 0;

  void changeSubCategoryI({required int changeSelectedSubCategory}) {
    changeSubCategory = changeSelectedSubCategory;

    emit(ChangeSubSelectedCategory());
  }

  List selectedList = [];
  List itemList = [];
  List controllers = [];

  void addSelectedItemList({required dynamic item, required dynamic items}) {
    final itemId = item['ProductID'];

    bool isAlreadySelected = selectedList.any(
      (selectedItem) => selectedItem['ProductID'] == itemId,
    );

    if (!isAlreadySelected) {
      itemList.add(items);
      selectedList.add(item);

      // initializeControllers();
      emit(AddItemListSelected());
    }
  }

  // void initializeControllers() {
  //   controllers = List.generate(selectedList.length, (index) {
  //
  //     if (selectedList.isNotEmpty && selectedList.length > index) {
  //       var selectedItem = selectedList[index];
  //
  //
  //       return TextEditingController(text: itemList[index]['Quantity'] != null
  //           ? itemList[index]['Quantity'].toString()
  //           : itemList[index]['Quantity']);
  //     }
  //
  //
  //     return TextEditingController(text: '5');
  //   });
  //
  //
  //
  //
  // }

  void update({required int index, required String newPrice}) {
    controllers[index] = newPrice;
    emit(UpdatePriceItem());
  }

  void deleteSelectedItemList({required dynamic index, int? itemId}) {
    selectedList.removeAt(index);
    itemList.removeAt(index);

    items.removeAt(index);
    if (itemId != null) {
      productQuantities[itemId] = 0;
    }
    emit(DeleteListSelected());
  }

  ScrollController scrollController = ScrollController();

  List<Map<String, dynamic>> payWaysList = [];

  void getPayWays() {
    emit(GetPayWaysLoadingState());

    DioHelper.getData(url: 'api/PayWays')
        .then((value) {
          var item = decrypt(value.data, privateKey, publicKey);
          payWaysList =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          emit(GetPayWaysSuccessState());
        })
        .catchError((error) {
          emit(GetPayWaysErrorState());
        });
  }

  num currencyId = 1;
  num currencyRate = 1;

  void updateCurrencyId({
    required dynamic newDataId,
    required dynamic newDataRate,
  }) {
    currencyId = newDataId;
    currencyRate = newDataRate;
    emit(ChangeDataState());
  }

  num patternID = -1;
  num branchId = 1;

  void updateBranchId({required dynamic newData}) {
    branchId = newData;
    emit(ChangeDataState());
  }

  void updatePatternID({required dynamic newDataId}) {
    print("patternId:$patternID");
    if (newDataId != null && newDataId != -1) {
      patternID = newDataId;
      // Save pattern ID to cache
      CacheHelper.saveData(key: "lastPatternID", value: patternID);
      print("Saved patternID to cache: $patternID");
      getLastInvoiceID();
      emit(ChangeDataState());
    }
  }

  // Add method to load pattern ID from cache
  void loadPatternIDFromCache() {
    final cachedPatternID = CacheHelper.getData(key: "lastPatternID");
    print("Loading patternID from cache: $cachedPatternID");
    if (cachedPatternID != null && cachedPatternID != -1) {
      patternID = cachedPatternID;
      print("Loaded patternID from cache: $patternID");
      getLastInvoiceID();
      emit(ChangeDataState());
    }
  }

  int lastInvoiceID = 0;
  int x = 0;
  void getLastInvoiceID() {
    if (patternID == -1) {
      print("Skipping getLastInvoiceID because patternID is -1");
      return;
    }

    emit(GetLastInvoiceIDLoading());
    print("Getting last invoice ID for patternID: $patternID");
    DioHelper.getData(
          url:
              'api/SalesInvoice/GetLastInvoiceByInvoiceID?InvoiceID=$patternID',
        )
        .then((value) {
          // Parse the invoice ID from the response
          int invoiceID = int.parse(value.data.toString());
          print("Received invoiceID: $invoiceID");
          print("Invoice");
          print('---------------------------------------------------------');
          print("invoice: ${value.data}");
          print("patternID$patternID");
          print(value);
          print(value.data);
          print("Invoice");
          print('---------------------------------------------------------');
          print(value);
          print('--------------------------------------------------');

          // Calculate the next invoice ID
          x = invoiceID + 1;
          print("PrintlastInvoiceID: $x");

          // Cache the value only if x is not 1
          if (x != 1) {
            CacheHelper.saveData(key: "lastInvoiceID", value: x);
            print("Cached lastInvoiceID: $x");
          } else {
            print("Skipping cache because lastInvoiceID is 1");
          }
          CacheHelper.saveData(key: "lastInvoiceID", value: x);

          // Debugging: Print the cached value (if it exists)
          print(
            "CacheHelper.getData(key: 'lastInvoiceID'): ${CacheHelper.getData(key: 'lastInvoiceID')}",
          );

          emit(GetLastInvoiceIDSuccess());
        })
        .catchError((error) {
          print("Error in getLastInvoiceID: $error");
          emit(GetLastInvoiceIDError());
        });
  }

  List printInvoice = [];

  Future<void> addOrderInFa({
    required BuildContext context,
    required String orderDate,
    required num totalValue,
    required List orderList,
    required int inviceno,
  }) async {
    final nameofuser = CacheHelper.getData(key: "name");

    //await fetchAndSendLocation(context);

    // if(customerInfo==null&&customer?['AccountID']==null)
    //   {
    //     Fluttertoast.showToast(
    //       msg: "يجب البحث عن الاسم\nYou must search for the name",
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.BOTTOM,
    //     );
    //
    //   }
    // else
    //   {
    emit(AddOrderLoading());
    List<Map<String, dynamic>> salesInvoiceItems =
        items
            .map(
              (product) => {
                "ProductID": product.ProductID,
                "RowNumber": product.RowNumber,
                "Quantity": product.quantity,
                "Price": product.price,
                "Notes": product.notes,
              },
            )
            .toList();

    String encryptedData = encryptData(
      {
        "InvoiceNo": inviceno,
        "InvoiceID": patternID,
        "InvoiceDate": orderDate,
        "CompanyBranchID": branchId,
        "Remainder":
            ((finalValue == 0.0) ? totalValue : finalValue) - sumUnPaid,
        "PrePaid": 0,
        "CurrencyID": currencyId,
        "Rate": currencyRate,
        "CustomerID": customerInfo?['AccountID'] ?? customer?['AccountID'],
        "TotalValue": totalValue,
        "TotalAddition": addition,
        "TotalDiscount": discount,
        "FinalValue": (finalValue == 0.0) ? totalValue : finalValue,
        "PayingType": codePw,
        "SalesInvoiceItems": salesInvoiceItems,

        "Address": address,
        "Createdby": nameofuser,

        //"UrlAddress": "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
        "Latitude": latitude,
        "Longitude": longitude,
        "SalesInvoicePayWays": paymentReceipt,
      },
      privateKey,
      publicKey,
    );
    if (!checkNotConect) {
      final operationData = {'jsonData': encryptedData, 'NumberFunction': 1};

      Hive.box('operation').add(operationData);
      print(
        'Operation saved locally: ${Hive.box('operation').values.toList()}',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('no_internet_operation_stored'.tr()),
          backgroundColor: Colors.orange,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      return;
    } else {
      print('----------------------------------------------');
      print(encryptedData);
      print('----------------------------------------------');
      var item = decrypt(encryptedData, privateKey, publicKey);
      print('***********************************************');
      print(item);
      print('************************************************');
      String jsonData = jsonEncode(encryptedData);

      DioHelper.postData(url: 'api/SalesInvoice/Create', data: jsonData)
          .then((value) {
            final decryptedText = decrypt(value.data, privateKey, publicKey);
            printInvoice.add(decryptedText);
            if (decryptedText.contains(
              'توجد أصناف ليس لها كمية في المخزن لم يتم إضافة الطلبية',
            )) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('items_out_of_stock_order_not_added'.tr()),
                  backgroundColor: Colors.red,
                ),
              );
            } else {
              var item = decrypt(encryptedData, privateKey, publicKey);
              printInvoice.add(selectedList);
              printInvoice.add(item);

              selectedList.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (Route<dynamic> route) => true,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('order_saved_successfully'.tr()),
                  backgroundColor: Colors.green,
                ),
              );
              final y = CacheHelper.getData(key: 'lastInvoiceID');
              final z = CacheHelper.saveData(
                key: "lastInvoiceID",
                value: y + 1,
              );
              Map<String, dynamic> selectedItem = jsonDecode(decryptedText);

              InvoiceModel dataInvoice = InvoiceModel.fromJson(selectedItem);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return InvoicePrint(dataInvoice: dataInvoice);
                  },
                ),
              );
            }
            emit(AddOrderSuccess());
          })
          .catchError((error) {
            emit(AddOrderError());
            print(error.hashCode);
            print(error.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('order_not_saved'.tr()),
                backgroundColor: Colors.red,
              ),
            );
          });
    }
  }

  double total = 0.0;
  num finalValue = 0.0;
  int quantityf = 0;

  void calculateTotal() {
    total = 0.0;
    quantityf = 0;

    for (Product item in items) {
      num quantity = item.quantity;

      num price = item.price;

      total += quantity * price;

      quantityf += int.parse(quantity.toStringAsFixed(0));
    }
  }

  void updatePrice({required int index, required double newPrice}) {
    items[index] = items[index].copyWith(price: newPrice);
    print(items[index].price);
    selectedList.elementAt(index)['Price'] = newPrice;
    itemList.elementAt(index)['Price'] = newPrice;
    calculateTotal();
    emit(UpdatePriceInListSuccess());
  }

  void updatenotes({required int index, required String notes}) {
    items[index] = items[index].copyWith(notes: notes);
    print(items[index].notes);
    selectedList.elementAt(index)['Notes'] = notes;
    itemList.elementAt(index)['Notes'] = notes;

    calculateTotal();
    emit(UpdatePriceInListSuccess());
  }

  num discount = 0;

  void updateFinalValue({
    required dynamic discountValue,
    required dynamic totaleValue,
  }) {
    discount = discountValue;
    final addition =
        additionValue.text.isNotEmpty ? num.parse(additionValue.text) : 0;
    finalValue = ((totaleValue - discountValue) + addition);
    emit(FinalValueUpdateSuccess());
  }

  void discountPercentFinalValue({
    required dynamic discountPercentage,
    required dynamic totaleValue,
  }) {
    double discountAmount = totaleValue * (discountPercentage / 100);
    discount = discountAmount;
    finalValue = ((totaleValue - discountAmount) + addition);
    emit(FinalValueUpdateSuccess());
  }

  void additionFinalValue({
    required dynamic additionValue,
    required dynamic totaleValue,
  }) {
    addition = additionValue;
    final discount =
        discountValue.text.isNotEmpty ? num.parse(discountValue.text) : 0;
    finalValue = ((totaleValue + additionValue) - discount);
    emit(FinalValueUpdateSuccess());
  }

  num addition = 0;

  void addPercentFinalValue({
    required dynamic addPercentage,
    required dynamic totaleValue,
  }) {
    double additionAmount = totaleValue * (addPercentage / 100);
    addition = additionAmount;
    finalValue = ((totaleValue + additionAmount) - discount);
    emit(FinalValueUpdateSuccess());
  }

  void getFinalValue({required dynamic finalVal}) {
    finalValue = finalVal;
    emit(FinalValueUpdateSuccess());
  }

  num codePw = 0;
  String namePaymentMethod = '';
  String namePaymentEnMethod = '';

  void updateCodePay({
    required dynamic newData,
    required String namePayment,
    required String nameEnPayment,
  }) {
    codePw = newData;
    namePaymentMethod = namePayment;
    namePaymentEnMethod = nameEnPayment;
    emit(ChangeDataState());
  }

  List<Map<String, dynamic>> paymentReceipt = [];
  num sumUnPaid = 0;

  void addReceipt({
    required double amountPaid,
    String? receiptNumber,
    num? codeP,
    String? namePaymentMetho,
    String? namePaymentEnMetho,
  }) {
    if (codePw != 0 && customerInfo == null && customer?['AccountID'] == null) {
      Fluttertoast.showToast(
        msg: "يجب البحث عن الاسم\nYou must search for the name",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      paymentReceipt.add({
        'PayingValue': amountPaid,
        'PayingType': codeP ?? codePw,
        'receiptNumber': receiptNumber ?? '-',
        'PayWayName': namePaymentMetho ?? namePaymentMethod,
        'PayWayEnName': namePaymentEnMetho ?? namePaymentEnMethod,
      });

      calculateUnpaid();
      emit(AddReceiptSuccess());
    }
  }

  void deleteReceipt({required int index}) {
    paymentReceipt.removeAt(index);
    calculateUnpaid();
    emit(DeleteReceiptSuccess());
  }

  int selectedRadio = 0;

  void changeSelectedRadio({required int select}) {
    selectedRadio = select;

    emit(ChangeSelecteRadioSuccess());
  }

  String orderDate = DateFormat('yyyy/MM/dd', 'en_US').format(DateTime.now());
  var receiptNumber = TextEditingController();
  var totalValue = TextEditingController();
  var discountValue = TextEditingController();
  var discountPercentage = TextEditingController();
  var additionValue = TextEditingController();
  var additionPercentage = TextEditingController();
  var result;

  Map<String, dynamic>? customerInfo;

  void updateCustomerInfo({required dynamic newData}) {
    customerInfo = newData;

    emit(ChangeDataState());
  }

  void editOrderInFa({
    required BuildContext context,
    required num totalValue,
    required List orderList,
    required dynamic editInvoice,
  }) {
    final nameofuser = CacheHelper.getData(key: "name");
    List<Map<String, dynamic>> modifiedOrderList =
        orderList.map((item) {
          Map<String, dynamic> modifiedItem = Map.from(item);
          if (modifiedItem.containsKey('ItemID')) {
            modifiedItem['ProductID'] = modifiedItem['ItemID'];
            modifiedItem.remove('ItemID');
          }
          return modifiedItem;
        }).toList();

    String encryptedData = encryptData(
      {
        "InvoiceID": editInvoice['InvoiceID'],
        "InvoiceNo": editInvoice['InvoiceNo'],
        "InvoiceDate": editInvoice['InvoiceDate'],
        "CompanyBranchID":
            (branchId == -1) ? editInvoice['CompanyBranchID'] : branchId,
        "PayingType": editInvoice['PayingType'],
        "Remainder":
            ((finalValue == 0.0) ? totalValue : finalValue) - sumUnPaid,
        "CurrencyID": currencyId,
        "PrePaid": 0,
        "Rate": currencyRate,
        "CustomerID": customer?['AccountID'] ?? editInvoice['CustomerID'],
        "TotalValue": totalValue,
        "TotalAddition": addition,
        "TotalDiscount": discount,
        "Createdby": nameofuser,
        "notes": "",
        "FinalValue": (finalValue == 0.0) ? totalValue : finalValue,
        "SalesInvoiceItems": modifiedOrderList,
        "SalesInvoicePayWays": paymentReceipt,
      },
      privateKey,
      publicKey,
    );

    print({
      "InvoiceID": editInvoice['InvoiceID'],
      "InvoiceNo": editInvoice['InvoiceNo'],
      "InvoiceDate": editInvoice['InvoiceDate'],
      "CompanyBranchID":
          (branchId == -1) ? editInvoice['CompanyBranchID'] : branchId,
      "PayingType": editInvoice['PayingType'],
      "Remainder": ((finalValue == 0.0) ? totalValue : finalValue) - sumUnPaid,
      "CurrencyID": currencyId,
      "PrePaid": 0,
      "Rate": currencyRate,
      "CustomerID": customer?['AccountID'] ?? editInvoice['CustomerID'],
      "TotalValue": totalValue,
      "TotalAddition": addition,
      "TotalDiscount": discount,
      "Createdby": nameofuser,
      "notes": "",
      "FinalValue": (finalValue == 0.0) ? totalValue : finalValue,
      "SalesInvoiceItems": modifiedOrderList,
      "SalesInvoicePayWays": paymentReceipt,
    });
    final decryptedText = decrypt(encryptedData, privateKey, publicKey);
    if (!checkNotConect) {
      final operationData = {'jsonData': encryptedData, 'NumberFunction': 2};

      Hive.box('operation').add(operationData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد اتصال بالإنترنت. تم تخزين العملية محليًا.'),
          backgroundColor: Colors.orange,
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
      return;
    } else {
      String jsonData = jsonEncode(encryptedData);
      print('-------------------------------------------------');
      print(jsonData);
      print('----------------------------------------------------');
      final decryptedText = decrypt(encryptedData, privateKey, publicKey);
      print(decryptedText);
      print('**********************************************************');
      emit(EditeOrderLoading());
      DioHelper.updateData(url: 'api/SalesInvoice/Edit', data: jsonData)
          .then((value) {
            final decryptedText = decrypt(value.data, privateKey, publicKey);

            if (decryptedText.contains(
              'This exception was thrown because the response has a status code of 405 and RequestOptions.validateStatus was configured to throw for this status code.',
            )) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error Error '),
                  backgroundColor: Colors.red,
                ),
              );
            } else {
              selectedList.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تعديل الفاتوره  بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
              Map<String, dynamic> selectedItem = jsonDecode(decryptedText);

              InvoiceModel dataInvoice = InvoiceModel.fromJson(selectedItem);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return InvoicePrint(dataInvoice: dataInvoice);
                  },
                ),
              );
            }
            emit(EditeOrderSuccess());
          })
          .catchError((error) {
            emit(EditeOrderError());
          });
    }
  }

  void calculateUnpaid() {
    sumUnPaid = 0;
    for (dynamic item in paymentReceipt) {
      double price = item['PayingValue'] ?? 0;
      sumUnPaid += price;
    }
  }

  bool isDiscountSelected = true;
  bool isAdditionSelected = false;
  bool isVisibility = true;

  void selectAddition() {
    isDiscountSelected = !isDiscountSelected;
    isAdditionSelected = !isAdditionSelected;
    isVisibility = !isVisibility;
    emit(ChangeDiscountOrAdditionMobile());
  }

  Map<int, int> productQuantities = {1246: 10};

  List<Product> items = [];

  void addItemCart({
    required int quantity,
    required String defaultUnitName,
    required int ProductID,
    required double price,
    required String name,
    required String notes,
    required int stock,
  }) {
    bool itemFound = false;

    for (var item in items) {
      if (item.ProductID == ProductID) {
        productQuantities[ProductID] = quantity;
        item.quantity = productQuantities[ProductID] ?? 0;
        item.notes = notes;
        emit(AddItemInCart());

        itemFound = true;
        break;
      }
    }

    if (!itemFound) {
      final newItem = Product(
        quantity: productQuantities[ProductID] ?? quantity,
        defaultUnitName: defaultUnitName,
        ProductID: ProductID,
        price: price,
        name: name,
        stock: stock,
      );
      items.add(newItem);
      productQuantities[ProductID] = quantity;

      emit(AddItemInCart());
    }
  }

  void printCart() {
    if (items.isEmpty) {
      return;
    }

    for (var item in items) {}
  }

  void subtractItemCart({required int quantity, required int ProductID}) {
    if (quantity < 0) {
      return; // الخروج من الدالة
    }

    for (var item in items) {
      if (item.ProductID == ProductID) {
        // التأكد من مقارنة ProductID

        productQuantities[ProductID] = quantity;
        item.quantity = quantity;

        if (quantity == 0) {
          items.remove(item); // حذف العنصر من القائمة
          emit(RemoveItemFromCart()); // إصدار حدث الحذف
        } else {
          emit(SubtractItemFromCart()); // إصدار حدث تقليل الكمية
        }

        return; // الخروج من الدالة بعد التعديل
      }
    }
  }

  Timer? debounce;
  List<Map<String, dynamic>> searchList = [];

  void searchKey({required searchKey}) {
    emit(SearchLoading());
    DioHelper.getData(url: '/api/Product/SearchProducts?searchKey=$searchKey')
        .then((value) {
          print(value.data);
          print('الداتا بعد فك التشفير');
          final decryptedText = decrypt(value.data, privateKey, publicKey);
          print(decryptedText);
          var newProducts =
              (json.decode(decryptedText) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();

          searchList = newProducts;
          print('-------------------------');
          print(searchList);
          print('*/---////---------------------');
          emit(SearchSuccess());
        })
        .catchError((error) {
          print('Error In Function Get Search  This Error ${error.toString()}');
          emit(SearchError());
        });
  }

  void searchBarCode({required searchKey}) {
    emit(SearchLoading());
    DioHelper.getData(
          url: '/api/Product/SearchProductByBarcode?Barcode=$searchKey',
        )
        .then((value) {
          print(value.data);
          print('الداتا بعد فك التشفير');
          final decryptedText = decrypt(value.data, privateKey, publicKey);
          print(decryptedText);
          var newProducts =
              (json.decode(decryptedText) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();

          searchList = newProducts;
          print('-------------------------');
          print(searchList);
          print('*/---////---------------------');
          emit(SearchSuccess());
        })
        .catchError((error) {
          print('Error In Function Get Search  This Error ${error.toString()}');
          emit(SearchError());
        });
  }

  Future<void> scanBarcode({
    required BuildContext context,
    required barcode,
  }) async {
    try {
      emit(SearchBarcodeScanning());

      if (barcode != null && barcode.isNotEmpty) {
        String trimmedBarcode = barcode.trim();

        emit(SearchBarcodeScanned(trimmedBarcode));

        searchBarCode(searchKey: trimmedBarcode);
      } else {
        emit(SearchBarcodeScanFailed("لم يتم العثور على رمز QR"));
      }
    } catch (e) {
      emit(SearchBarcodeScanFailed("حدث خطأ أثناء المسح: $e"));
    }
  }
}
