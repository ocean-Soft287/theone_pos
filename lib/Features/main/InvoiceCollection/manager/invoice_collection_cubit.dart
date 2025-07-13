import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:theonepos/main.dart';

import '../../../../corec/apis/dioHelper.dart';
import '../../../../corec/apis/encrupt.dart';

import '../../../../corec/sharde/consts.dart';
import '../../home/screen/home_screen.dart';
import '../../newInvoice/manager/product_cubit.dart';
import '../../search/invoice_collection_search/model/invoice_collection_model.dart';
import '../../search/invoice_collection_search/screen/collection _voucher_printing_Screen.dart';
import 'invoice_collection_state.dart';

class InvoiceCollectionCubit extends Cubit<InvoiceCollectionState> {
  InvoiceCollectionCubit() : super(InitializeInvoiceCollectionState());
  ProductViewCubit? product;

  List<Map<String, dynamic>> allBoundsTypeList =
      Hive.box(('Bonds')).values
          .map((value) => Map<String, dynamic>.from(value as Map))
          .toList() ??
      [];
  void getAllBonds() {
    emit(GetAllBondsLoadingState());
    DioHelper.getData(url: 'api/VoucherSettings/GetReceiptsVouchersTypes')
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);
          List<Map<String, dynamic>> allBoundsTypeList2 =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          await Hive.box('Bonds').clear();
          for (var item in allBoundsTypeList2) {

            final box = Hive.box('Bonds');

            await box.add(item);

          }
          allBoundsTypeList =
              Hive.box('Bonds').values.cast<Map<String, dynamic>>().toList();
          nameTypeIdController.text =
              allBoundsTypeList[0]['CustomerName'].toString();
          voucherTypeId = allBoundsTypeList[0]['VoucherType'];
          emit(GetAllBondsSuccessState());
        })
        .catchError((error) {
          nameTypeIdController.text =
              allBoundsTypeList[0]['CustomerName'].toString();
          voucherTypeId = allBoundsTypeList[0]['VoucherType'];
          emit(GetAllBondsErrorState());
        });
  }

  var voucherValueControlle = TextEditingController();
  var voucherValueControllerTwo = TextEditingController();

  void updateVoucher({
    required num invoiceNO,
    required num invoiceId,
    required dynamic newData,
    required dynamic newDataTwo,
  }) {
    voucherValueControlle.text = newData.toString();
    voucherValueControllerTwo.text = newDataTwo.toString();

    invoiceNo = invoiceNO;
    invoiceID = invoiceId;
    emit(ChangeDataState());
  }

  var creditAccount = TextEditingController();

  dynamic blancee;
  void updateCreditAccount({
    required dynamic newData,
    required dynamic blance,
  }) {
    creditAccount.text = newData.toString();
    blancee = blance;
    emit(ChangeDataState());
  }

  List<Map<String, dynamic>> allCurrenciesList =
      Hive.box('Currencies').values
          .map((value) => Map<String, dynamic>.from(value as Map))
          .toList() ??
      [];
  void getAllCurrencies() {
    emit(GetAllCurrenciesLoadingState());
    DioHelper.getData(url: 'api/Currencies')
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);
          List<Map<String, dynamic>> allCurrenciesList2 =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          await Hive.box('Currencies').clear();
          for (var item in allCurrenciesList2) {
            final box = Hive.box('Currencies');
            await box.add(item);
          }

          allCurrenciesList =
              Hive.box(
                'Currencies',
              ).values.cast<Map<String, dynamic>>().toList();
          currencyId = allCurrenciesList[0]['CurrencyID'];
          currencyRate = allCurrenciesList[0]['Rate'];
          rateController.text = allCurrenciesList[0]['Rate'].toString();

          emit(GetAllCurrenciesSuccessState());
        })
        .catchError((error) {
          currencyId = allCurrenciesList[0]['CurrencyID'];
          currencyRate = allCurrenciesList[0]['Rate'];
          rateController.text = allCurrenciesList[0]['Rate'].toString();
          emit(GetAllCurrenciesErrorState());
        });
  }

  List<Map<String, dynamic>> allCompanyBranchesList0 =
      Hive.box('mainBranches').values
          .map((value) => Map<String, dynamic>.from(value as Map))
          .toList() ??
      [];
  void getCompanyBranchesO() {
    emit(GetAllCompanyBranchesLoadingState());
    DioHelper.getData(
          url:
              'api/CompanyBranches/GetCompanyBranchesByUserID?UserID=$userId&serverName=$ipAddress&UserName=$userNameServer&UserPassword=$passwordServer&DBName=$databaseName',
        )
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);
          List<Map<String, dynamic>> allCompanyBranchesList02 =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          await Hive.box('mainBranches').clear();
          for (var item in allCompanyBranchesList02) {
            final box = Hive.box('mainBranches');
            await box.add(item);
          }
          getInvoiceSettingByBranchID(
            branchId: allCompanyBranchesList02[0]["ID"],
          );
          allCompanyBranchesList0 =
              Hive.box(
                'mainBranches',
              ).values.cast<Map<String, dynamic>>().toList();
          branchId = allCompanyBranchesList0[0]["ID"];
          product?.branchId = allCompanyBranchesList0[0]["ID"];
          product?.updateBranchId(newData: allCompanyBranchesList0[0]["ID"]);

          print('***************************');
          print(allCompanyBranchesList0.length);
          print('**********************************');
          emit(GetAllCompanyBranchesSuccessState());
        })
        .catchError((error) {
          print('****************');
          branchId = allCompanyBranchesList0[0]["ID"];
          product?.branchId = allCompanyBranchesList0[0]["ID"];
          product?.updateBranchId(newData: allCompanyBranchesList0[0]["ID"]);
          print(error.toString());
          emit(GetAllCompanyBranchesErrorState());
        });
  }

  List<Map<dynamic, dynamic>> allCompanyBranchesList = [];
  void getCompanyBranches({required dynamic customerId}) {
    emit(GetAllCompanyBranchesLoadingState());
    DioHelper.getData(
          url:
              'api/CustomerBranches/GetCustomerBranchesByCustomerID?CustomerID=$customerId',
        )
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);
          allCompanyBranchesList =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();

          getInvoiceSettingByBranchID(branchId: allCompanyBranchesList[0]);

          for (var item in allCompanyBranchesList) {
            final box = Hive.box('mainBranches');
            await box.add(item);
          }
          print(Hive.box('mainBranches').values.toList());

          emit(GetAllCompanyBranchesSuccessState());
        })
        .catchError((error) {
          // print(error.toString());

          emit(GetAllCompanyBranchesErrorState());
        });
  }

  List<Map<dynamic, dynamic>> allInvoiceSettingByBranchIDList = [];
  void getInvoiceSettingByBranchID({required dynamic branchId}) async {
    emit(GetInvoiceSettingByBranchIDLoading());

    var box = await Hive.openBox('invoiceSettings');

    if (box.containsKey(branchId)) {
      allInvoiceSettingByBranchIDList =
          (box.get(branchId) as List<dynamic>)
              .map((item) => (item as Map).cast<String, dynamic>())
              .toList();

      emit(GetInvoiceSettingByBranchIDSuccess());
    } else {
      DioHelper.getData(
            url:
                'api/InvoiceSetting/GetInvoiceSettingByBranchID?BranchID=$branchId',
          )
          .then((value) {
            var item = decrypt(value.data, privateKey, publicKey);
            var newInvoiceSettings =
                (json.decode(item) as List<dynamic>)
                    .map((item) => item as Map<String, dynamic>)
                    .toList();

            allInvoiceSettingByBranchIDList = newInvoiceSettings;
            box.put(branchId, allInvoiceSettingByBranchIDList);

            product!.updatePatternID(
              newDataId: allInvoiceSettingByBranchIDList[0]['PatternID'],
            );
            emit(GetInvoiceSettingByBranchIDSuccess());
          })
          .catchError((error) {
            emit(GetInvoiceSettingByBranchIDError());
          });
    }
  }

  num currencyId = 0;
  num currencyRate = 0;
  num branchId = 0;
  num codePw = 0;
  var nameTypeIdController = TextEditingController();
  num voucherTypeId = 0;
  var result;
  void updateResult({required dynamic newData}) {
    result = newData;
    emit(ChangeDataState());
  }

  void updateBranchId({required dynamic newData}) {
    branchId = newData;
    emit(ChangeDataState());
  }

  void updateCurrencyId({required dynamic newData}) {
    currencyId = newData;
    emit(ChangeDataState());
  }

  void updateCurrencyRate({required dynamic newData}) {
    currencyRate = newData;
    rateController.text = newData.toString();
    emit(ChangeDataState());
  }

  void updateCodePay({required dynamic newData}) {
    codePw = newData;
    emit(ChangeDataState());
  }

  void updateVoucherTypeId({
    required dynamic newData,
    required dynamic customerID,
  }) {
    nameTypeIdController.text = newData.toString();
    voucherTypeId = customerID;
    emit(ChangeDataState());
  }

  List<Map<String, dynamic>> payWaysList =
      Hive.box(('PayWays')).values
          .map((value) => Map<String, dynamic>.from(value as Map))
          .toList() ??
      [];
  void getPayWays() {
    emit(GetPayWaysLoadingState());

    DioHelper.getData(url: 'api/PayWays')
        .then((value) async {
          var item = decrypt(value.data, privateKey, publicKey);

          List<Map<String, dynamic>> payWaysList2 =
              (json.decode(item) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          await Hive.box('PayWays').clear();
          for (var item in payWaysList2) {
            final box = Hive.box('PayWays');
            await box.add(item);
          }
          payWaysList =
              Hive.box('PayWays').values.cast<Map<String, dynamic>>().toList();
          codePw = payWaysList[0]['Code_PW'];
          emit(GetPayWaysSuccessState());
        })
        .catchError((error) {
          codePw = payWaysList[0]['Code_PW'];
          emit(GetPayWaysErrorState());
        });
  }

  String CreationDateTime = DateFormat(
    'yyyy/MM/dd',
    'en_US',
  ).format(DateTime.now());
  String CheckDueDate = DateFormat(
    'yyyy/MM/dd',
    'en_US',
  ).format(DateTime.now());
  var noteController = TextEditingController();
  var checkNumberController = TextEditingController();
  var keyNetController = TextEditingController();
  var agreementNoController = TextEditingController();
  var rateController = TextEditingController();
  num? acId;
  num invoiceNo = 0;
  num invoiceID = 0;

  void addInvoiceCollecting({
    required BuildContext context,
    required String CreationDateTime,
    required String CheckDueDate,
    required String notes,
    required String checkNumber,
    required String agreementNo,
    required String keyNet,
    required num acId,
  }) async {
    String encryptedData = encryptData(
      {
        "BranchId": branchId,
        "CreationDateTime": CreationDateTime,
        "Code_PW": codePw,
        "CurrencyId": currencyId,
        "CurrencyRate": currencyRate,
        "VoucherValue": num.parse(voucherValueControllerTwo.text),
        "CheckNumber": checkNumber,
        "CheckDueDate": CheckDueDate,
        "Notes": notes,
        "VoucherType": voucherTypeId,
        "InvoiceID": invoiceID,
        "InvoiceNo": invoiceNo,
        "VoucherAccounts": [
          {
            "AcId": acId,
            "AgreementNo": num.parse(agreementNo),
            "KeyNet": num.parse(keyNet),
          },
        ],
      },
      privateKey,
      publicKey,
    );

    final decryptedText = decrypt(encryptedData, privateKey, publicKey);
    log(decryptedText);

    String jsonData = jsonEncode(encryptedData);
    if (!checkNotConect) {
      final operationData = {'jsonData': jsonData, 'NumberFunction': 0};

      Hive.box('operation').add(operationData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد اتصال بالإنترنت. تم تخزين العملية محليًا.'),
          backgroundColor: Colors.orange,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      return;
    } else {
      emit(AddInvoiceCollectingLoading());
      DioHelper.postData(url: 'api/Voucher/InvoiceCollecting', data: jsonData)
          .then((value) {
            final decryptedText = decrypt(value.data, privateKey, publicKey);

            if (decryptedText != "Not Found Voucher") {
              final decryptedText = decrypt(value.data, privateKey, publicKey);

              Map<String, dynamic> jsonData = jsonDecode(decryptedText);
              VoucherModel voucher = VoucherModel.fromJson(jsonData);

              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          CollectionVoucherPrinting(voucherModel: voucher),
                ),
              );
            }
            emit(AddInvoiceCollectingSuccess());
          })
          .catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(decryptedText),
                backgroundColor: Colors.red,
              ),
            );
            emit(AddInvoiceCollectingError());
          });
    }
  }

  final formKey = GlobalKey<FormState>();

  void editInvoiceCollecting({
    required BuildContext context,
    required String CreationDateTime,
    required String CheckDueDate,
    required String notes,
    required String checkNumber,
    required String agreementNo,
    required num voucherNumber,
    required num invoiceID,
    required num invoiceNo,
    required String keyNet,
    required num acId,
    required num branchId,
    required num codePw,
    required num currencyId,
    required num currencyRate,
    required num voucherTypeId,
  }) async {
    String encryptedData = encryptData(
      {
        "VoucherNumber": voucherNumber,
        "BranchId": branchId,
        "CreationDateTime": CreationDateTime,
        "Code_PW": codePw,
        "CurrencyId": currencyId,
        "CurrencyRate": currencyRate,
        "VoucherValue": num.parse(voucherValueControllerTwo.text),
        "CheckNumber": checkNumber,
        "CheckDueDate": CheckDueDate,
        "Notes": notes,
        "VoucherType": voucherTypeId,
        "InvoiceID": invoiceID,
        "InvoiceNo": invoiceNo,
        "VoucherAccounts": [
          {
            "AcId": acId,
            "AgreementNo": num.parse(agreementNo),
            "KeyNet": num.parse(keyNet),
          },
        ],
      },
      privateKey,
      publicKey,
    );

    final decryptedText = decrypt(encryptedData, privateKey, publicKey);
    String jsonData = jsonEncode(encryptedData);

    if (!checkNotConect) {
      final operationData = {'jsonData': jsonData, 'NumberFunction': 3};

      Hive.box('operation').add(operationData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد اتصال بالإنترنت. تم تخزين العملية محليًا.'),
          backgroundColor: Colors.orange,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      return;
    } else {
      emit(EditInvoiceCollectingLoading());
      DioHelper.updateData(
            url: 'api/Voucher/UpdateInvoiceCollecting',
            data: jsonData,
          )
          .then((value) {
            final decryptedText = decrypt(value.data, privateKey, publicKey);

            if (decryptedText.contains('$voucherNumber')) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '$decryptedText',
                  ), // وضع النص بين single quotation
                  backgroundColor: Colors.red,
                ),
              );
            }
            emit(EditInvoiceCollectingSuccess());
          })
          .catchError((error) {
            emit(EditInvoiceCollectingError());
          });
    }
  }
}
