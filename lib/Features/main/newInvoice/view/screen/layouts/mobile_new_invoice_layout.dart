import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:theonepos/Features/main/newInvoice/view/screen/search_screen.dart';
import 'package:theonepos/Features/main/newInvoice/view/screen/Invoice_summary.dart';

import 'package:theonepos/Features/main/newInvoice/manager/product_state.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_cubit.dart';

import 'package:theonepos/corec/sharde/consts.dart';
import 'package:theonepos/corec/sharde/font_responsive.dart';

import 'package:theonepos/corec/utils/widget/data_picker.dart';
import '../../../../InvoiceCollection/manager/invoice_collection_cubit.dart';
import '../../../../InvoiceCollection/manager/invoice_collection_state.dart';
import '../../../model/product_model.dart';
import '../../widget/component_category_listView.dart';
import '../../widget/component_product_grid_view.dart';
import '../../widget/component_sub_category_listView.dart';

class MobileNewInvoiceLayout extends StatelessWidget {
  final dynamic editInvoice;
  const MobileNewInvoiceLayout({super.key, this.editInvoice});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    String currentLanguageCode = currentLocale.languageCode;
    ProductViewCubit itemBloc = BlocProvider.of<ProductViewCubit>(context);
    if (editInvoice != null) {
      BlocProvider.of<ProductViewCubit>(context).currencyId =
          editInvoice["CurrencyID"];
      BlocProvider.of<ProductViewCubit>(context).patternID =
          editInvoice["InvoiceID"];
      BlocProvider.of<ProductViewCubit>(context).branchId =
          editInvoice!["CompanyBranchID"];
      BlocProvider.of<ProductViewCubit>(context).currencyRate =
          editInvoice!['Rate'];
      //

      // BlocProvider.of<ProductViewCubit>(context).initializeControllers();
      for (int i = 0; i < editInvoice['SalesInvoiceItems'].length; i++) {
        var item = editInvoice['SalesInvoiceItems'][i];
        BlocProvider.of<ProductViewCubit>(
              context,
            ).productQuantities[item["ProductID"]] =
            (item["Quantity"] ?? 0.0).toInt();

        BlocProvider.of<ProductViewCubit>(context).items.add(
          Product(
            RowNumber: item["RowNumber"],
            RowSate: "U",
            defaultUnitName: item["DefaultUnitArName"] ?? '0',
            ProductID: item["ProductID"],
            name: item["ProductArName"],
            quantity: item["Quantity"] ?? 0,
            price: item["Price"] ?? 0,
            stock: item["StockQuantity"] ?? 0,
          ),
        );
        BlocProvider.of<ProductViewCubit>(context).itemList.add({
          "RowNumber": item["RowNumber"],
          "RowState": "U",
          "defaultUnitName": item["DefaultUnitArName"] ?? '0',
          "ProductID": item["ProductID"],
          "name": item["ProductArName"],
          "quantity": item["Quantity"] ?? 0,
          "price": item["Price"] ?? 0,
          "stock": item["StockQuantity"] ?? 0,
        });
        BlocProvider.of<ProductViewCubit>(context).selectedList.add({
          "RowNumber": item["RowNumber"],
          "RowState": "U",
          "defaultUnitName": item["DefaultUnitArName"] ?? '0',
          "ProductID": item["ProductID"],
          "name": item["ProductArName"],
          "quantity": item["Quantity"] ?? 0,
          "price": item["Price"] ?? 0,
          "stock": item["StockQuantity"] ?? 0,
        });
      }
    }

    return BlocConsumer<ProductViewCubit, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        ProductViewCubit itemBloc = BlocProvider.of<ProductViewCubit>(context);
        Locale currentLocale = context.locale;
        String currentLanguageCode = currentLocale.languageCode;
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            // alignment: Alignment.bottomCenter,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Material(
                      elevation: 2,
                      color: const Color(0xffF0FAFF),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Text(
                                  'new_invoice'.tr(),
                                  style: GoogleFonts.almarai(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return SearchScreen(
                                            itemBloc: itemBloc,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.search),
                                ),
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.shopping_cart,
                                        color: Color(0xff343FB9),
                                      ),
                                      onPressed: () {},
                                    ),
                                    if (itemBloc.itemList.isNotEmpty)
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(6.0),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              12.0,
                                            ),
                                          ),
                                          child: Text(
                                            '${itemBloc.itemList.length}',
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 4,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                            .4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'seller'.tr(),
                                              style: GoogleFonts.almarai(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Container(
                                              width:
                                                  MediaQuery.sizeOf(
                                                    context,
                                                  ).width,
                                              height: 30,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                  ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: const Color(
                                                    0xffF59E0B,
                                                  ),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  SellerName.toString(),
                                                  style: GoogleFonts.almarai(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'currency'.tr(),
                                              style: GoogleFonts.almarai(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            SizedBox(
                                              width:
                                                  MediaQuery.sizeOf(
                                                    context,
                                                  ).width *
                                                  .5,
                                              height: 30,
                                              child: BlocBuilder<
                                                InvoiceCollectionCubit,
                                                InvoiceCollectionState
                                              >(
                                                builder: (context, state) {
                                                  InvoiceCollectionCubit
                                                  itemBloc2 = BlocProvider.of<
                                                    InvoiceCollectionCubit
                                                  >(context);

                                                  return DropdownButtonFormField<
                                                    Map<String, dynamic>
                                                  >(
                                                    value:
                                                        editInvoice != null &&
                                                                itemBloc2
                                                                    .allCurrenciesList
                                                                    .isNotEmpty
                                                            ? itemBloc2
                                                                .allCurrenciesList
                                                                .firstWhere(
                                                                  (currency) =>
                                                                      currency['CurrencyID'] ==
                                                                      editInvoice["CurrencyID"],
                                                                  orElse:
                                                                      () =>
                                                                          itemBloc2
                                                                              .allCurrenciesList[0],
                                                                )
                                                            : (itemBloc2
                                                                    .allCurrenciesList
                                                                    .isEmpty
                                                                ? null
                                                                : itemBloc2
                                                                    .allCurrenciesList[0]),

                                                    // value: itemBloc2.allCurrenciesList.isNotEmpty ? itemBloc2.allCurrenciesList[0] : null,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 16.0,
                                                          ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8.0,
                                                            ),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      hintText: 'currency'.tr(),
                                                      hintStyle:
                                                          GoogleFonts.almarai(
                                                            color: const Color(
                                                              0xff333333,
                                                            ),
                                                            fontSize:
                                                                getFontSize(
                                                                  context,
                                                                  14,
                                                                ),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                    ),
                                                    items:
                                                        itemBloc2.allCurrenciesList.map((
                                                          Map<String, dynamic>
                                                          item,
                                                        ) {
                                                          return DropdownMenuItem<
                                                            Map<String, dynamic>
                                                          >(
                                                            value: item,
                                                            child: Text(
                                                              (currentLanguageCode ==
                                                                      'ar')
                                                                  ? item['CurrencyName'] ??
                                                                      'unknown'
                                                                          .tr()
                                                                  : item['CurrencyEName'] ??
                                                                      'unknown'
                                                                          .tr(),
                                                              style: GoogleFonts.almarai(
                                                                color:
                                                                    const Color(
                                                                      0xff333333,
                                                                    ),
                                                                fontSize:
                                                                    getFontSize(
                                                                      context,
                                                                      14,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                    onChanged: (
                                                      Map<String, dynamic>?
                                                      newValue,
                                                    ) {
                                                      if (newValue != null) {
                                                        itemBloc2.updateCurrencyId(
                                                          newData:
                                                              newValue['CurrencyID'],
                                                        );
                                                        itemBloc2
                                                            .updateCurrencyRate(
                                                              newData:
                                                                  newValue['Rate'],
                                                            );
                                                        itemBloc2
                                                                .rateController
                                                                .text =
                                                            newValue['Rate']
                                                                .toString();
                                                        itemBloc.updateCurrencyId(
                                                          newDataId:
                                                              newValue['CurrencyID'],
                                                          newDataRate:
                                                              newValue['Rate'],
                                                        );
                                                      }

                                                      print(newValue);
                                                      print(
                                                        itemBloc2.currencyId,
                                                      );
                                                      print(
                                                        itemBloc2.currencyId,
                                                      );
                                                      print(
                                                        itemBloc.currencyId,
                                                      );

                                                      // newValue: editInvoice != null
                                                      //     ? itemBloc2.allCurrenciesList.firstWhere(
                                                      //       (currency) => currency['CurrencyID'] == editInvoice['CurrencyID'],
                                                      //
                                                      // ) : null;
                                                    },
                                                    style: TextStyle(
                                                      color: const Color(
                                                        0xff333333,
                                                      ),
                                                      fontSize: getFontSize(
                                                        context,
                                                        16,
                                                      ),
                                                      fontFamily: 'Raleway',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Color(0xff333333),
                                                    ),
                                                    dropdownColor: Colors.white,
                                                    elevation: 8,
                                                    isExpanded: true,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,

                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'branch'.tr(),
                                            style: GoogleFonts.almarai(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .33.w,
                                            height: 30,
                                            child: BlocBuilder<
                                              InvoiceCollectionCubit,
                                              InvoiceCollectionState
                                            >(
                                              builder: (context, state) {
                                                InvoiceCollectionCubit
                                                itemBloc2 = BlocProvider.of<
                                                  InvoiceCollectionCubit
                                                >(context);
                                      
                                                return DropdownButtonFormField<
                                                  Map<dynamic, dynamic>
                                                >(
                                                  value:
                                                      editInvoice != null &&
                                                              itemBloc2
                                                                  .allCompanyBranchesList0
                                                                  .isNotEmpty
                                                          ? itemBloc2
                                                              .allCompanyBranchesList0
                                                              .firstWhere(
                                                                (branch) =>
                                                                    branch["ID"] ==
                                                                    editInvoice!["CompanyBranchID"],
                                                                orElse:
                                                                    () =>
                                                                        itemBloc2
                                                                            .allCompanyBranchesList0[0],
                                                              )
                                                          : (itemBloc2
                                                                  .allCompanyBranchesList0
                                                                  .isNotEmpty
                                                              ? itemBloc2
                                                                  .allCompanyBranchesList0[0]
                                                              : null),
                                                  items:
                                                      itemBloc2.allCompanyBranchesList0.map((
                                                        branch,
                                                      ) {
                                                        return DropdownMenuItem<
                                                          Map<
                                                            dynamic,
                                                            dynamic
                                                          >
                                                        >(
                                                          value: branch,
                                                          child: Text(
                                                            currentLanguageCode ==
                                                                    'ar'
                                                                ? branch['BraName'] ??
                                                                    ''
                                                                : branch['BranchEName'] ??
                                                                    '',
                                                            style: GoogleFonts.almarai(
                                                              color:
                                                                  const Color(
                                                                    0xff333333,
                                                                  ),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                  onChanged: (
                                                    Map<dynamic, dynamic>?
                                                    selectedItem,
                                                  ) {
                                                    if (selectedItem !=
                                                        null) {
                                                      itemBloc2.updateBranchId(
                                                        newData:
                                                            selectedItem["ID"],
                                                      );
                                                      itemBloc2
                                                          .getInvoiceSettingByBranchID(
                                                            branchId:
                                                                selectedItem["ID"],
                                                          );
                                                      itemBloc.updateBranchId(
                                                        newData:
                                                            selectedItem["ID"],
                                                      );
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 16.0,
                                                        ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8.0,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color:
                                                                Colors.blue,
                                                            width: 2,
                                                          ),
                                                    ),
                                                    hintText:
                                                        "select_branch".tr(),
                                                    hintStyle:
                                                        const TextStyle(
                                                          color: Color(
                                                            0xff333333,
                                                          ),
                                                          fontFamily:
                                                              'Raleway',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                  ),
                                                  style: GoogleFonts.almarai(
                                                    color: const Color(
                                                      0xff333333,
                                                    ),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width:10,),
                                        Expanded(
                                          child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'pattern'.tr(),
                                              style: GoogleFonts.almarai(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            SizedBox(
                                              // width:
                                              //     MediaQuery.sizeOf(
                                              //       context,
                                              //     ).width *
                                              //     .1.w,
                                             
                                              height: 30,
                                              child: BlocBuilder<
                                                InvoiceCollectionCubit,
                                                InvoiceCollectionState
                                              >(
                                                builder: (context, state) {
                                                  InvoiceCollectionCubit
                                                  itemBloc2 = BlocProvider.of<
                                                    InvoiceCollectionCubit
                                                  >(context);
                                                  ProductViewCubit productCubit =
                                                      BlocProvider.of<
                                                        ProductViewCubit
                                                      >(context);
                                          
                                                  if (productCubit.patternID ==
                                                      -1) {
                                                    itemBloc.updatePatternID(
                                                      newDataId:
                                                          itemBloc2
                                                              .allInvoiceSettingByBranchIDList[0]['PatternID'],
                                                    );
                                          
                                                    itemBloc.getLastInvoiceID();
                                                    if (itemBloc2
                                                        .allInvoiceSettingByBranchIDList
                                                        .isNotEmpty) {
                                                      productCubit.patternID =
                                                          itemBloc2
                                                              .allInvoiceSettingByBranchIDList[0]['PatternID'] ??
                                                          -1;
                                                      print(
                                                        "itemBloc2.allInvoiceSettingByBranchIDList![0]['PatternID']${itemBloc2.allInvoiceSettingByBranchIDList[0]['PatternID']}",
                                                      );
                                          
                                                      itemBloc.updatePatternID(
                                                        newDataId:
                                                            itemBloc2
                                                                .allInvoiceSettingByBranchIDList[0]['PatternID'],
                                                      );
                                                      itemBloc.getLastInvoiceID();
                                                    }
                                                  }
                                          
                                                  // التعامل مع Null List
                                                  List<Map<dynamic, dynamic>>
                                                  invoiceList =
                                                      itemBloc2
                                                          .allInvoiceSettingByBranchIDList ??
                                                      [];
                                          
                                                  return DropdownButtonFormField<
                                                    Map<dynamic, dynamic>
                                                  >(
                                                    value:
                                                        editInvoice != null &&
                                                                invoiceList
                                                                    .isNotEmpty
                                                            ? invoiceList.firstWhere(
                                                              (pattern) =>
                                                                  pattern['PatternID'] ==
                                                                  editInvoice['InvoiceID'],
                                                              orElse:
                                                                  () =>
                                                                      invoiceList[0],
                                                            )
                                                            : (invoiceList
                                                                    .isNotEmpty
                                                                ? invoiceList[0]
                                                                : null), // تعيين null إذا لم تكن هناك بيانات
                                          
                                                    items:
                                                        invoiceList.isNotEmpty
                                                            ? invoiceList.map((
                                                              item,
                                                            ) {
                                                              return DropdownMenuItem<
                                                                Map<
                                                                  dynamic,
                                                                  dynamic
                                                                >
                                                              >(
                                                                value: item,
                                                                child: Text(
                                                                  item['PatternName'] ??
                                                                      'النمط',
                                                                  style: GoogleFonts.almarai(
                                                                    color: const Color(
                                                                      0xff333333,
                                                                    ),
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              );
                                                            }).toList()
                                                            : [], // التأكد من أن `items` لا تكون `null`
                                          
                                                    onChanged: (
                                                      Map<dynamic, dynamic>?
                                                      selectedItem,
                                                    ) {
                                                      if (selectedItem != null) {
                                                        itemBloc.updatePatternID(
                                                          newDataId:
                                                              selectedItem['PatternID'],
                                                        );
                                                        itemBloc
                                                            .getLastInvoiceID();
                                                      }
                                                      print(selectedItem);
                                                    },
                                          
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 16.0,
                                                          ),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8.0,
                                                            ),
                                                        borderSide:
                                                            const BorderSide(
                                                              color: Colors.blue,
                                                              width: 2,
                                                            ),
                                                      ),
                                                      hintText: "اختر النمط",
                                                      hintStyle: const TextStyle(
                                                        color: Color(0xff333333),
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                          
                                                    style: GoogleFonts.almarai(
                                                      color: const Color(
                                                        0xff333333,
                                                      ),
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                                                                ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ComponentCategoryListView(itemBloc: itemBloc),
                    ComponentSubCategoryListView(itemBloc: itemBloc),
                    ComponentProductGridView(itemBloc: itemBloc),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DatePickerWidget(
                          onDateSelected: (DateTime? selectedDate) {
                            print(
                              "Selected date: ${DateFormat('yyyy/MM/dd', 'en_US').format(selectedDate!)}",
                            );
                            DateTime dateToFormat =
                                selectedDate ?? DateTime.now();
                            itemBloc.orderDate =
                                itemBloc.orderDate ??
                                DateFormat(
                                  'yyyy/MM/dd',
                                  'en_US',
                                ).format(DateTime.now());
                          },
                          widthH: MediaQuery.sizeOf(context).width * .3,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .25,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF59E0B),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'previous'.tr(),
                          style: GoogleFonts.almarai(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .25,
                      child: ElevatedButton(
                        onPressed: () {
                          print(itemBloc.patternID);
                          print(itemBloc.branchId);

                          if (itemBloc.patternID == -1) {
                            Fluttertoast.showToast(
                              msg: "يرجى اختيار الفرع والنمط",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                            );
                          } else if (itemBloc.itemList.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "يرجى اختيار مجموعه من الاصناف",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                            );
                          } else {
                            if (editInvoice != null) {
                              BlocProvider.of<ProductViewCubit>(
                                context,
                              ).paymentReceipt.clear();
                              for (
                                int i = 0;
                                i < editInvoice['SalesInvoicePayWays'].length;
                                i++
                              ) {
                                var item =
                                    editInvoice['SalesInvoicePayWays'][i];
                                BlocProvider.of<ProductViewCubit>(
                                  context,
                                ).addReceipt(
                                  amountPaid: item['PayingValue'],
                                  codeP: item['PayingType'],
                                  receiptNumber: item['ReferenceNo'],
                                  namePaymentEnMetho: item['PayWayEnName'],
                                  namePaymentMetho: item['PayWayName'],
                                );
                              }
                            }
                            itemBloc.calculateTotal();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => InvoiceSummary(
                                      itemCubit: itemBloc,
                                      editInvoice: editInvoice,
                                    ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF59E0B),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'next'.tr(),
                          style: GoogleFonts.almarai(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
