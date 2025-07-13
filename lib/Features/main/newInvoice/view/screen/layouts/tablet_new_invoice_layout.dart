import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_state.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_cubit.dart';
import 'package:theonepos/Features/main/newInvoice//view/screen/search_screen.dart';
import 'package:theonepos/Features/main/newInvoice//view/screen/Invoice_summary.dart';

import 'package:theonepos/Features/main/newInvoice/view/widget/show_price_update_dialog.dart';

import 'package:theonepos/corec/sharde/consts.dart';
import 'package:theonepos/corec/sharde/font_responsive.dart';
import 'package:theonepos/corec/utils/widget/data_picker.dart';
import 'package:theonepos/corec/utils/widget/time_picker.dart';
import '../../../../InvoiceCollection/manager/invoice_collection_cubit.dart';
import '../../../../InvoiceCollection/manager/invoice_collection_state.dart';
import '../../../model/product_model.dart';
import '../../widget/component_category_listView.dart';
import '../../widget/component_product_grid_view.dart';
import '../../widget/component_sub_category_listView.dart';

class TabletNewInvoiceLayout extends StatelessWidget {
  TabletNewInvoiceLayout({super.key, this.editInvoice});
  dynamic editInvoice;
  @override
  Widget build(BuildContext context) {
    ProductViewCubit itemBloc = BlocProvider.of<ProductViewCubit>(context);
    BlocProvider.of<ProductViewCubit>(context).loadPatternIDFromCache();
    print(MediaQuery.of(context).size.width);

    if (editInvoice != null) {
      BlocProvider.of<ProductViewCubit>(context).currencyId =
          editInvoice["CurrencyID"];
      BlocProvider.of<ProductViewCubit>(context).patternID =
          editInvoice["InvoiceID"];
      BlocProvider.of<ProductViewCubit>(context).branchId =
          editInvoice!["CompanyBranchID"];
      BlocProvider.of<ProductViewCubit>(context).currencyRate =
          editInvoice!['Rate'];
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

    Locale currentLocale = context.locale;
    String currentLanguageCode = currentLocale.languageCode;

    return BlocConsumer<ProductViewCubit, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        Locale currentLocale = context.locale;
        String currentLanguageCode = currentLocale.languageCode;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .3,
                    child: Container(
                      color: const Color(0xffEDF3FB),
                      child: Column(
                        children: [
                          Container(
                            color: const Color(0xff001926),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        'item'.tr(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'quantity'.tr(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'unit'.tr(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'price'.tr(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'total'.tr(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'balance'.tr(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
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
                                    child: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              controller: itemBloc.scrollController,
                              separatorBuilder:
                                  (context, index) => const SizedBox(height: 5),
                              itemBuilder: (context, index) {
                                var item = itemBloc.items[index];
                                return GestureDetector(
                                  onTap: () {
                                    itemBloc.changeSelected(
                                      changeSelectedItem: index,
                                    );

                                    // print(itemBloc.selectedList);
                                    // print(itemBloc.selectedList.length);
                                    print(itemBloc.items[index].price);
                                    print(itemBloc.itemList);
                                    print(itemBloc.itemList.length);
                                    print(itemBloc.items);
                                    print(itemBloc.items.length);

                                    print(itemBloc.items[index].price);
                                  },
                                  child: Dismissible(
                                    key: Key(
                                      itemBloc.items[index].ProductID
                                          .toString(),
                                    ),
                                    background: Container(color: Colors.red),
                                    onDismissed: (direction) {
                                      itemBloc.deleteSelectedItemList(
                                        itemId: item.ProductID,
                                        index: index,
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                            'item_removed_successfully'.tr(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border:
                                            (itemBloc.changeSelectedItemList ==
                                                    index)
                                                ? Border.all(
                                                  color: const Color(
                                                    0xffEDF3FB,
                                                  ),
                                                  width: 0,
                                                )
                                                : Border.all(
                                                  color: const Color(
                                                    0xff3CA38B,
                                                  ),
                                                ),
                                        color:
                                            (itemBloc.changeSelectedItemList ==
                                                    index)
                                                ? const Color(0xff343FB9)
                                                : const Color(0xffEDF3FB),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 18,
                                        horizontal: 6,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () {
                                                showNoteDialog(
                                                  context: context,
                                                  index: index,
                                                  cubit: itemBloc,
                                                  note:
                                                      itemBloc
                                                          .items[index]
                                                          .notes
                                                          .toString(),
                                                );
                                              },
                                              child: Text(
                                                item.name,
                                                style: TextStyle(
                                                  color:
                                                      (itemBloc.changeSelectedItemList ==
                                                              index)
                                                          ? Colors.white
                                                          : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${itemBloc.productQuantities[item.ProductID] ?? 0}', // إذا كانت null سيتم إرجاع 0
                                              style: TextStyle(
                                                color:
                                                    (itemBloc.changeSelectedItemList ==
                                                            index)
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              item.defaultUnitName,
                                              style: TextStyle(
                                                color:
                                                    (itemBloc.changeSelectedItemList ==
                                                            index)
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                showPriceUpdateDialog(
                                                  context: context,
                                                  index: index,
                                                  cubit: itemBloc,
                                                  currentPrice:
                                                      itemBloc
                                                          .items[index]
                                                          .price,
                                                );
                                              },
                                              child: Text(
                                                '${item.price}',
                                                style: TextStyle(
                                                  color:
                                                      (itemBloc.changeSelectedItemList ==
                                                              index)
                                                          ? Colors.white
                                                          : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              (item.price *
                                                      (itemBloc
                                                              .productQuantities[item
                                                              .ProductID] ??
                                                          0))
                                                  .toStringAsFixed(3),
                                              style: TextStyle(
                                                color:
                                                    (itemBloc.changeSelectedItemList ==
                                                            index)
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${item.stock}',
                                              style: TextStyle(
                                                color:
                                                    (itemBloc.changeSelectedItemList ==
                                                            index)
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: itemBloc.items.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ComponentCategoryListView(itemBloc: itemBloc),
                  ComponentSubCategoryListView(itemBloc: itemBloc),
                  ComponentProductGridView(
                    itemBloc: itemBloc,
                    editInvoice: editInvoice,
                  ),
                ],
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                color: const Color(0xff343FB9),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'seller'.tr(),
                                style: GoogleFonts.almarai(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.sizeOf(context).width,
                                height: 42,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xffF59E0B),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    SellerName.toString(),
                                    style: GoogleFonts.almarai(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'currency'.tr(),
                                style: GoogleFonts.almarai(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * .5,
                                height: 60,
                                child: BlocBuilder<
                                  InvoiceCollectionCubit,
                                  InvoiceCollectionState
                                >(
                                  builder: (context, state) {
                                    InvoiceCollectionCubit itemBloc2 =
                                        BlocProvider.of<InvoiceCollectionCubit>(
                                          context,
                                        );

                                    return DropdownButtonFormField<
                                      Map<String, dynamic>
                                    >(
                                      value:
                                          editInvoice != null &&
                                                  itemBloc2
                                                      .allCurrenciesList
                                                      .isNotEmpty
                                              ? itemBloc2.allCurrenciesList.firstWhere(
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
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: 'currency'.tr(),
                                        hintStyle: GoogleFonts.almarai(
                                          color: const Color(0xff333333),
                                          fontSize: getFontSize(context, 14),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      items:
                                          itemBloc2.allCurrenciesList.map((
                                            Map<String, dynamic> item,
                                          ) {
                                            return DropdownMenuItem<
                                              Map<String, dynamic>
                                            >(
                                              value: item,
                                              child: Text(
                                                (currentLanguageCode == 'ar')
                                                    ? item['CurrencyName'] ??
                                                        'unknown'.tr()
                                                    : item['CurrencyEName'] ??
                                                        'unknown'.tr(),
                                                style: GoogleFonts.almarai(
                                                  color: const Color(
                                                    0xff333333,
                                                  ),
                                                  fontSize: getFontSize(
                                                    context,
                                                    14,
                                                  ),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                      onChanged: (
                                        Map<String, dynamic>? newValue,
                                      ) {
                                        if (newValue != null) {
                                          itemBloc2.updateCurrencyId(
                                            newData: newValue['CurrencyID'],
                                          );
                                          itemBloc2.updateCurrencyRate(
                                            newData: newValue['Rate'],
                                          );
                                          itemBloc2.rateController.text =
                                              newValue['Rate'].toString();
                                          itemBloc.updateCurrencyId(
                                            newDataId: newValue['CurrencyID'],
                                            newDataRate: newValue['Rate'],
                                          );
                                        }

                                        print(newValue);
                                        print(itemBloc2.currencyId);
                                        print(itemBloc2.currencyId);
                                        print(itemBloc.currencyId);

                                        // newValue: editInvoice != null
                                        //     ? itemBloc2.allCurrenciesList.firstWhere(
                                        //       (currency) => currency['CurrencyID'] == editInvoice['CurrencyID'],
                                        //
                                        // ) : null;
                                      },
                                      style: TextStyle(
                                        color: const Color(0xff333333),
                                        fontSize: getFontSize(context, 16),
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w700,
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
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  print(editInvoice);
                                },
                                child: Text(
                                  'branch'.tr(),
                                  style: GoogleFonts.almarai(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * .5,
                                height: 60,
                                child: BlocBuilder<
                                  InvoiceCollectionCubit,
                                  InvoiceCollectionState
                                >(
                                  builder: (context, state) {
                                    InvoiceCollectionCubit itemBloc2 =
                                        BlocProvider.of<InvoiceCollectionCubit>(
                                          context,
                                        );
                                    ProductViewCubit productCubit =
                                        BlocProvider.of<ProductViewCubit>(
                                          context,
                                        );

                                    if (productCubit.patternID == -1) {
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
                                    List<Map<dynamic, dynamic>> invoiceList =
                                        itemBloc2
                                            .allInvoiceSettingByBranchIDList ??
                                        [];

                                    return DropdownButtonFormField<
                                      Map<dynamic, dynamic>
                                    >(
                                      value:
                                          editInvoice != null &&
                                                  invoiceList.isNotEmpty
                                              ? invoiceList.firstWhere(
                                                (pattern) =>
                                                    pattern['PatternID'] ==
                                                    editInvoice['InvoiceID'],
                                                orElse: () => invoiceList[0],
                                              )
                                              : (invoiceList.isNotEmpty
                                                  ? invoiceList[0]
                                                  : null), // تعيين null إذا لم تكن هناك بيانات

                                      items:
                                          invoiceList.isNotEmpty
                                              ? invoiceList.map((item) {
                                                return DropdownMenuItem<
                                                  Map<dynamic, dynamic>
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
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                );
                                              }).toList()
                                              : [], // التأكد من أن `items` لا تكون `null`

                                      onChanged: (
                                        Map<dynamic, dynamic>? selectedItem,
                                      ) {
                                        if (selectedItem != null) {
                                          itemBloc.updatePatternID(
                                            newDataId:
                                                selectedItem['PatternID'],
                                          );
                                          itemBloc.getLastInvoiceID();
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
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                            width: 2,
                                          ),
                                        ),
                                        hintText: "اختر النمط",
                                        hintStyle: const TextStyle(
                                          color: Color(0xff333333),
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),

                                      style: GoogleFonts.almarai(
                                        color: const Color(0xff333333),
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
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'pattern'.tr(),
                                style: GoogleFonts.almarai(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * .5,
                                height: 60,
                                child: BlocBuilder<
                                  InvoiceCollectionCubit,
                                  InvoiceCollectionState
                                >(
                                  builder: (context, state) {
                                    InvoiceCollectionCubit itemBloc2 =
                                        BlocProvider.of<InvoiceCollectionCubit>(
                                          context,
                                        );
                                    if (BlocProvider.of<ProductViewCubit>(
                                          context,
                                        ).patternID ==
                                        -1) {
                                      itemBloc.getLastInvoiceID();
                                      itemBloc.patternID =
                                          BlocProvider.of<
                                            InvoiceCollectionCubit
                                          >(
                                            context,
                                          ).allInvoiceSettingByBranchIDList[0]['PatternID'] ??
                                          -1;
                                    }

                                    return DropdownButtonFormField<
                                      Map<dynamic, dynamic>
                                    >(
                                      value:
                                          editInvoice != null &&
                                                  itemBloc2
                                                      .allInvoiceSettingByBranchIDList
                                                      .isNotEmpty
                                              ? itemBloc2
                                                  .allInvoiceSettingByBranchIDList
                                                  .firstWhere(
                                                    (pattern) =>
                                                        pattern['PatternID'] ==
                                                        editInvoice['InvoiceID'],
                                                    orElse:
                                                        () =>
                                                            itemBloc2
                                                                    .allInvoiceSettingByBranchIDList[0]
                                                                as Map<
                                                                  String,
                                                                  dynamic
                                                                >,
                                                  )
                                              : (itemBloc2
                                                      .allInvoiceSettingByBranchIDList
                                                      .isNotEmpty
                                                  ? itemBloc2
                                                          .allInvoiceSettingByBranchIDList[0]
                                                      as Map<String, dynamic>
                                                  : null),
                                      items:
                                          itemBloc2
                                              .allInvoiceSettingByBranchIDList
                                              .map((item) {
                                                return DropdownMenuItem<
                                                  Map<dynamic, dynamic>
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
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                );
                                              })
                                              .toList(),
                                      onChanged: (
                                        Map<dynamic, dynamic>? selectedItem,
                                      ) {
                                        if (selectedItem != null) {
                                          itemBloc.updatePatternID(
                                            newDataId:
                                                selectedItem['PatternID'],
                                          );
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
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                            width: 2,
                                          ),
                                        ),
                                        hintText: "اختر النمط",
                                        hintStyle: const TextStyle(
                                          color: Color(0xff333333),
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      style: GoogleFonts.almarai(
                                        color: const Color(0xff333333),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DatePickerWidget(
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
                          heightH: 60,
                          widthH: MediaQuery.sizeOf(context).width * .2,
                          fillColor: const Color(0xffE7EBEF),
                        ),
                        TimePickerWidget(
                          heightH: 60,
                          widthH: MediaQuery.sizeOf(context).width * .2,
                          fillColor: const Color(0xffE7EBEF),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF59E0B),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'previous'.tr(),
                              style: GoogleFonts.almarai(
                                fontSize: getFontSize(context, 16),
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: ElevatedButton(
                            onPressed: () {
                              if (itemBloc.patternID == -1) {
                                Fluttertoast.showToast(
                                  msg: "يرجى اختيار الفرع والنمط",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                );
                              } else if (itemBloc.itemList.isEmpty &&
                                  itemBloc.items.isEmpty) {
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
                                    i <
                                        editInvoice['SalesInvoicePayWays']
                                            .length;
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
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'next'.tr(),
                              style: GoogleFonts.almarai(
                                fontSize: getFontSize(context, 16),
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
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
