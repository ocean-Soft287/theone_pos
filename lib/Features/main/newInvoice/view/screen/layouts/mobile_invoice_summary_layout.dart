import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Corec/local/chacheHelper.dart';
import 'package:theonepos/corec/sharde/consts.dart';
import 'package:theonepos/corec/utils/widget/custom_field.dart';
import 'package:theonepos/corec/utils/widget/custom_text_field.dart';
import 'package:theonepos/Features/main/InvoiceCollection/manager/invoice_collection_cubit.dart';
import 'package:theonepos/Features/main/InvoiceCollection/manager/invoice_collection_state.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_cubit.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_state.dart';
import 'package:theonepos/Features/main/newInvoice/view/screen/new_invoice_view.dart';
import 'package:theonepos/Features/main/newInvoice/view/widget/show_price_update_dialog.dart';
import 'package:theonepos/Features/main/search/customer_search/screen/search_screen.dart';
import 'package:theonepos/corec/sharde/font_responsive.dart';
import 'package:theonepos/main.dart';

import 'package:geolocator/geolocator.dart' show Geolocator;

class MobileInvoiceSummaryLayout extends StatelessWidget {
  ProductViewCubit itemCubit;
  final dynamic editInvoice;
  final int numofInvoice;
  MobileInvoiceSummaryLayout({
    super.key,
    required this.itemCubit,
    this.editInvoice,
    required this.numofInvoice,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductViewCubit>(context).fetchAndSendLocation(context);
    // Load pattern ID from cache
    BlocProvider.of<ProductViewCubit>(context).loadPatternIDFromCache();
    final currentLocale = context.locale;

    return BlocConsumer<ProductViewCubit, ProductState>(
      bloc: itemCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<InvoiceCollectionCubit, InvoiceCollectionState>(
                builder: (context, state) {
                  InvoiceCollectionCubit itemBloc2 =
                      BlocProvider.of<InvoiceCollectionCubit>(context);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .3,
                        child: Container(
                          color: const Color(0xffEDF3FB),
                          child: Column(
                            children: [
                              Container(
                                color: const Color(0xff2269A6),
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
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  controller: itemCubit.scrollController,
                                  separatorBuilder:
                                      (context, index) =>
                                          const SizedBox(height: 5),
                                  itemBuilder: (context, index) {
                                    var item = itemCubit.items[index];
                                    return GestureDetector(
                                      onTap: () {
                                        itemCubit.changeSelected(
                                          changeSelectedItem: index,
                                        );
                                      },
                                      child: Dismissible(
                                        key: Key(item.name),
                                        background: Container(
                                          color: Colors.red,
                                        ),
                                        onDismissed: (direction) {
                                          itemCubit.deleteSelectedItemList(
                                            index: index,
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                'item_removed_successfully'
                                                    .tr(),
                                              ),
                                            ),
                                          );
                                          itemCubit.calculateTotal();
                                          if (itemCubit.items.isEmpty) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        NewInvoiceView(),
                                              ),
                                            );
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                (itemCubit.changeSelectedItemList ==
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
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
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
                                                      cubit: itemCubit,
                                                      note:
                                                          itemCubit
                                                              .items[index]
                                                              .notes
                                                              .toString(),
                                                    );
                                                    print(
                                                      itemCubit
                                                          .items[index]
                                                          .notes
                                                          .toString(),
                                                    );
                                                  },
                                                  child: Text(
                                                    item.name,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${itemCubit.productQuantities[item.ProductID] ?? 0}', // إذا كانت null سيتم إرجاع 0
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),

                                              Expanded(
                                                flex: 1,
                                                child: InkWell(
                                                  onTap: () {
                                                if(SellerName == "مدير"){
                                                    showPriceUpdateDialog(
                                                      context: context,
                                                      index: index,
                                                      cubit: itemCubit,
                                                      currentPrice:
                                                          itemCubit
                                                              .items[index]
                                                              .price,
                                                    );
                                                }
                                                 },
                                                  child: Text(
                                                    '${item.price}',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  ((itemCubit.productQuantities[item
                                                                  .ProductID] ??
                                                              0) *
                                                          item.price)
                                                      .toStringAsFixed(3),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),

                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${item.stock}',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: itemCubit.items.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'to_account'.tr(),
                                  style: GoogleFonts.almarai(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                Container(
                                  width: MediaQuery.sizeOf(context).width * .6,
                                  height: 40.h,
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
                                      editInvoice != null
                                          ? '${editInvoice['CustomerName']}'
                                          : itemCubit.customerInfo != null
                                          ? '${itemCubit.customerInfo!['AcountName']}'
                                          : customer != null
                                          ? '${customer!['AcountName']}'
                                          : 'search_account'.tr(),
                                      style: GoogleFonts.almarai(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .3,
                            child: ElevatedButton(
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => SearchScreen(
                                          patternID: itemCubit.patternID,
                                        ),
                                  ),
                                );

                                itemCubit.updateCustomerInfo(newData: result);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffff5a545),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'search'.tr(),
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
                      12.verticalSpace,

                      BlocBuilder<ProductViewCubit, ProductState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'total'.tr(),
                                    style: GoogleFonts.almarai(
                                      color: const Color(0xff29568C),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: const Color(0xffF5A545),
                                    ),
                                    width:
                                        MediaQuery.sizeOf(context).width * .25,
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        itemCubit.total.toStringAsFixed(3),
                                        style: GoogleFonts.almarai(
                                          fontSize: 15.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  if (accessHaveDiscount == 1)
                                    Visibility(
                                      visible: itemCubit.isVisibility,
                                      replacement: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .2,
                                            child: CustomField(
                                              controller:
                                                  itemCubit.additionValue,
                                              onChanged: (value) {
                                                final additionValue =
                                                    value.isNotEmpty
                                                        ? num.parse(value)
                                                        : 0;
                                                itemCubit.additionFinalValue(
                                                  additionValue: additionValue,
                                                  totaleValue: itemCubit.total,
                                                );
                                                itemCubit
                                                    .additionPercentage
                                                    .text = ((additionValue /
                                                            itemCubit.total) *
                                                        100)
                                                    .toStringAsFixed(2);
                                                itemCubit.getFinalValue(
                                                  finalVal:
                                                      itemCubit.finalValue,
                                                );
                                              },
                                              textColor: Colors.black,
                                              hintText: '',
                                              enableColor: Colors.white,
                                              fillColor: Colors.white,
                                              borderColor: Colors.white,
                                              focusedColor: Colors.orange,
                                            ),
                                          ),
                                          Text(
                                            '=',
                                            style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .2,
                                            child: CustomField(
                                              controller:
                                                  itemCubit.additionPercentage,
                                              onChanged: (value) {
                                                final additionPercentage =
                                                    value.isNotEmpty
                                                        ? num.parse(value)
                                                        : 0;
                                                itemCubit.addPercentFinalValue(
                                                  addPercentage:
                                                      additionPercentage,
                                                  totaleValue: itemCubit.total,
                                                );
                                                itemCubit.additionValue.text =
                                                    ((additionPercentage /
                                                                100) *
                                                            itemCubit.total)
                                                        .toStringAsFixed(2);
                                                itemCubit.getFinalValue(
                                                  finalVal:
                                                      itemCubit.finalValue,
                                                );
                                              },
                                              textColor: Colors.black,
                                              hintText: '',
                                              enableColor: Colors.white,
                                              fillColor: Colors.white,
                                              borderColor: Colors.white,
                                              focusedColor: Colors.orange,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '%',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .2,
                                            child: CustomField(
                                              controller:
                                                  itemCubit.discountValue,
                                              onChanged: (value) {
                                                final discountValue =
                                                    value.isNotEmpty
                                                        ? num.parse(value)
                                                        : 0;
                                                itemCubit.updateFinalValue(
                                                  discountValue: discountValue,
                                                  totaleValue: itemCubit.total,
                                                );
                                                itemCubit
                                                    .discountPercentage
                                                    .text = ((discountValue /
                                                            itemCubit.total) *
                                                        100)
                                                    .toStringAsFixed(2);
                                                itemCubit.getFinalValue(
                                                  finalVal:
                                                      itemCubit.finalValue,
                                                );
                                              },
                                              textColor: Colors.black,
                                              hintText: '',
                                              enableColor: Colors.white,
                                              fillColor: Colors.white,
                                              borderColor: Colors.white,
                                              focusedColor: Colors.orange,
                                            ),
                                          ),
                                          Text(
                                            '=',
                                            style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .2,
                                            child: CustomField(
                                              controller:
                                                  itemCubit.discountPercentage,
                                              onChanged: (value) {
                                                final discountPercentage =
                                                    value.isNotEmpty
                                                        ? num.parse(value)
                                                        : 0;
                                                itemCubit
                                                    .discountPercentFinalValue(
                                                      discountPercentage:
                                                          discountPercentage,
                                                      totaleValue:
                                                          itemCubit.total,
                                                    );
                                                itemCubit.discountValue.text =
                                                    ((discountPercentage /
                                                                100) *
                                                            itemCubit.total)
                                                        .toStringAsFixed(2);
                                                itemCubit.getFinalValue(
                                                  finalVal:
                                                      itemCubit.finalValue,
                                                );
                                              },
                                              textColor: Colors.black,
                                              hintText: '',
                                              enableColor: Colors.white,
                                              fillColor: Colors.white,
                                              borderColor: Colors.white,
                                              focusedColor: Colors.orange,
                                            ),
                                          ),
                                          Text(
                                            '%',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              8.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'net'.tr(),
                                    style: GoogleFonts.almarai(
                                      color: const Color(0xff29568C),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: const Color(0xff29568C),
                                    ),
                                    width:
                                        MediaQuery.sizeOf(context).width * .25,
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        (itemCubit.finalValue == 0.0)
                                            ? itemCubit.total.toStringAsFixed(3)
                                            : itemCubit.finalValue
                                                .toStringAsFixed(3),
                                        style: GoogleFonts.almarai(
                                          fontSize: 15.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (accessHaveDiscount == 1)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Radio<bool>(
                                          value: true,
                                          groupValue:
                                              itemCubit.isDiscountSelected,
                                          onChanged: (bool? value) {
                                            itemCubit.selectAddition();
                                          },
                                        ),
                                        Text(
                                          'discount'.tr(),
                                          style: GoogleFonts.almarai(
                                            color: const Color(0xff29568C),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (accessHaveDiscount == 1)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Radio<bool>(
                                          value: true,
                                          groupValue:
                                              itemCubit.isAdditionSelected,
                                          onChanged: (bool? value) {
                                            itemCubit.selectAddition();
                                          },
                                        ),
                                        Text(
                                          'add'.tr(),
                                          style: GoogleFonts.almarai(
                                            color: const Color(0xff29568C),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),

                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * .4,
                              child: CustomTextField(
                                textColor: Colors.black,
                                hintColor: Colors.black,
                                labelText: 'paid'.tr(),
                                labelColor: Colors.black,
                                hintText: (itemCubit.sumUnPaid).toStringAsFixed(
                                  3,
                                ),
                                enableColor: Colors.white,
                                fillColor: Colors.white,
                                borderColor: Colors.white,
                                controller: itemCubit.totalValue,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]*\.?[0-9]*'),
                                  ), // Allows all numbers
                                  TextInputFormatter.withFunction((
                                    oldValue,
                                    newValue,
                                  ) {
                                    if (newValue.text.isNotEmpty) {
                                      double? enteredValue = double.tryParse(
                                        newValue.text,
                                      );
                                      num finalValue =
                                          itemCubit.finalValue == 0.0
                                              ? itemCubit.total
                                              : itemCubit.finalValue;

                                      if (enteredValue != null &&
                                          enteredValue > finalValue) {
                                        return oldValue;
                                      }
                                    }
                                    return newValue;
                                  }),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * .4,
                              child: CustomTextField(
                                enableColor: Colors.white,
                                fillColor: Colors.white,
                                borderColor: Colors.white,

                                hintColor: Colors.black,
                                textColor: Colors.black,
                                readOnly: true,
                                labelText: 'total_quantity'.tr(),
                                labelColor: Colors.black,
                                hintText: '${itemCubit.quantityf}',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .4,
                            child: CustomTextField(
                              enableColor: Colors.white,
                              fillColor: Colors.white,
                              borderColor: Colors.white,
                              hintColor: Colors.black,
                              textColor: Colors.black,
                              readOnly: true,
                              labelText: 'unpaid'.tr(),
                              labelColor: Colors.black,
                              hintText: ((itemCubit.finalValue <= 0.0
                                          ? itemCubit.total
                                          : itemCubit.finalValue) -
                                      itemCubit.sumUnPaid)
                                  .toStringAsFixed(3),
                            ),
                          ),

                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .4,
                            child: CustomTextField(
                              enableColor: Colors.white,
                              fillColor: Colors.white,
                              borderColor: Colors.white,
                              hintColor: Colors.black,
                              textColor: Colors.black,
                              readOnly: true,
                              labelText: 'item_count'.tr(),
                              labelColor: Colors.black,
                              hintText: '${itemCubit.itemList.length}',
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'payment_method'.tr(),
                                  style: GoogleFonts.almarai(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                //      accessHaveDiscount==1?
                                BlocBuilder<InvoiceCollectionCubit, InvoiceCollectionState>(
                                  builder: (context, state) {
                                    InvoiceCollectionCubit itemBloc2 = BlocProvider.of<InvoiceCollectionCubit>(context);

                                    // تصفية قائمة طرق الدفع بناءً على accessHaveDiscount
                                    List<Map<String, dynamic>> filteredPayWaysList =
                                    accessHaveDiscount != 1
                                        ?itemBloc2.payWaysList.toList()
                                    // itemBloc2.payWaysList
                                    // .where((item) =>  item['Code_PW'] == 1)
                                    // .toList()
                                        :itemBloc2.payWaysList.toList();
                                    //     : itemBloc2.payWaysList;

                                    return filteredPayWaysList.isEmpty
                                        ? const SizedBox.shrink()
                                        : DropdownButtonFormField<Map<String, dynamic>>(
                                      value: null, // لا يتم تحديد قيمة مبدئية
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          borderSide: BorderSide.none,
                                        ),

                                        hintText:
                                        // `filteredPayWaysList.isNotEmpty
                                        //     ? (currentLocale.languageCode == 'ar'
                                        //     ? filteredPayWaysList[0]['Name_PW'] ?? 'unknown'.tr()
                                        //     : filteredPayWaysList[0]['EName_PW'] ?? 'unknown'.tr())
                                        //     :`
                                        'payment_method'.tr(),
                                        hintStyle: GoogleFonts.almarai(
                                          color: const Color(0xff333333),
                                          fontSize: getFontSize(context, 14),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      items: filteredPayWaysList.map((Map<String, dynamic> item) {
                                        return DropdownMenuItem<Map<String, dynamic>>(
                                          value: item,
                                          child: Text(
                                            currentLocale.languageCode == 'ar'
                                                ? item['Name_PW'] ?? 'unknown'.tr()
                                                : item['EName_PW'] ?? 'unknown'.tr(),
                                            style: GoogleFonts.almarai(
                                              color: const Color(0xff333333),
                                              fontSize: getFontSize(context, 14),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (Map<String, dynamic>? newValue) {
                                        if (newValue != null) {
                                          itemCubit.updateCodePay(
                                            newData: newValue['Code_PW'],
                                            namePayment: newValue['Name_PW'],
                                            nameEnPayment: newValue['EName_PW'],
                                          );


                                          if (newValue['Code_PW'] == 0) {
                                            itemCubit.totalValue.text = itemCubit.total.toStringAsFixed(3);
                                          }

                                          itemCubit.receiptNumber.text = '';
                                        }
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

                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            flex: 2,
                            child: CustomTextField(
                              labelText: 'receipt_number'.tr(),
                              labelColor: Colors.black,
                              hintText: '0',
                              enableColor: Colors.black,
                              fillColor: Colors.white,
                              borderColor: Colors.black,
                              controller: itemCubit.receiptNumber,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            flex: 3,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (itemCubit.totalValue.text.isEmpty &&
                                    itemCubit.namePaymentMethod.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg:
                                        "يرجى إدخال طريقة الدفع والمبلغ المدفوع\nPlease enter the payment method and amount paid",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                } else {
                                  itemCubit.addReceipt(
                                    receiptNumber: itemCubit.receiptNumber.text,
                                    amountPaid: double.parse(
                                      itemCubit.totalValue.text.isNotEmpty
                                          ? itemCubit.totalValue.text
                                          : '0',
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 24,
                                color: Colors.white,
                              ),
                              label: Text(
                                'add'.tr(),
                                style: GoogleFonts.almarai(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff2957CB),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      8.verticalSpace,
                      Container(
                        color: Colors.indigo,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  'payment_method'.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getFontSize(context, 14),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: Colors.white,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'paid'.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getFontSize(context, 14),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: Colors.white,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'receipt_number'.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getFontSize(context, 14),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: itemCubit.paymentReceipt.length,
                          itemBuilder:
                              (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                (currentLocale.languageCode ==
                                                        'ar')
                                                    ? itemCubit
                                                        .paymentReceipt[index]['PayWayName']
                                                    : itemCubit
                                                        .paymentReceipt[index]['PayWayEnName'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: getFontSize(
                                                    context,
                                                    14,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Monadi',
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 30,
                                              color: Colors.white,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '${itemCubit.paymentReceipt[index]['PayingValue']}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: getFontSize(
                                                    context,
                                                    14,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Monadi',
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 30,
                                              color: Colors.white,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                '${itemCubit.paymentReceipt[index]['receiptNumber']}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: getFontSize(
                                                    context,
                                                    14,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Monadi',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 30,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              itemCubit.deleteReceipt(
                                                index: index,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 1),
                                  ],
                                ),
                              ),
                        ),
                      ),

                      20.verticalSpace,
                      Center(
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * .4,
                          child:
                              (editInvoice != null)
                                  ? ConditionalBuilder(
                                    condition:
                                        itemCubit.state is! EditeOrderLoading,
                                    builder:
                                        (context) => ElevatedButton.icon(
                                          onPressed: () {
                                            itemCubit.editOrderInFa(
                                              context: context,
                                              orderList: itemCubit.itemList,
                                              totalValue: itemCubit.total,
                                              editInvoice: editInvoice,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            'edit'.tr(),
                                            style: GoogleFonts.almarai(
                                              fontSize: getFontSize(
                                                context,
                                                18,
                                              ),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xff2957CB,
                                            ), // لون الخلفية
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    8,
                                                  ), // شكل مستدير للحواف
                                            ),
                                          ),
                                        ),
                                    fallback:
                                        (context) => const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 5.0,
                                            backgroundColor: Colors.black,
                                            color: Colors.blue,
                                            semanticsLabel:
                                                'Linear progress indicator',
                                          ),
                                        ),
                                  )
                                  : ConditionalBuilder(
                                    condition:
                                        itemCubit.state is! AddOrderLoading,
                                    builder:
                                        (context) => ElevatedButton.icon(
                                          onPressed:
                                          itemCubit.paymentReceipt.isNotEmpty
                                              ? () async {


                                            double startLatitude =
                                            CacheHelper.getData(
                                              key: "mylat",
                                            );
                                            double startLongitude =
                                            CacheHelper.getData(
                                              key: "mylong",
                                            );
                                            double endLatitude =
                                            CacheHelper.getData(
                                              key: "customerLat",
                                            );
                                            double endLongitude =
                                            CacheHelper.getData(
                                              key: "customerLong",
                                            );

                                            double distanceInMeters =
                                            Geolocator.distanceBetween(
                                              startLatitude,
                                              startLongitude,
                                              endLatitude,
                                              endLongitude,
                                            );
                                            // if (endLongitude == 0.0 ||
                                            //     endLatitude == 0.0) {
                                            //   itemCubit.addOrderInFa(
                                            //     orderDate:
                                            //         itemCubit.orderDate ??
                                            //         DateFormat(
                                            //           'yyyy/MM/dd',
                                            //           'en_US',
                                            //         ).format(DateTime.now()),
                                            //     context: context,
                                            //     orderList: itemCubit.itemList,
                                            //     totalValue: itemCubit.total,
                                            //     inviceno: numofInvoice,
                                            //   );
                                            // } else if (distanceInMeters <=
                                            //     250)
                                                {
                                              itemCubit.addOrderInFa(
                                                orderDate:
                                                itemCubit.orderDate ??
                                                    DateFormat(
                                                      'yyyy/MM/dd',
                                                      'en_US',
                                                    ).format(DateTime.now()),
                                                context: context,
                                                orderList: itemCubit.itemList,
                                                totalValue: itemCubit.total,
                                                inviceno: numofInvoice,
                                              );
                                              print("itemBloc2.payWaysList[itemBloc2.codePw.toInt()]['PayWayName']");
                                              print("itemBloc2.payWaysList[itemBloc2.codePw.toInt()]['PayWayEnName']");
                                              print(itemBloc2.payWaysList[itemBloc2.codePw.toInt()]['PayWayName']);
                                              print(itemBloc2.payWaysList[itemBloc2.codePw.toInt()]['PayWayEnName']);
                                            }
                                            // else {
                                            //   Fluttertoast.showToast(
                                            //     msg:
                                            //         "المسافة بينك وبين العميل أكبر من 50 متر!",
                                            //     toastLength: Toast.LENGTH_LONG,
                                            //     gravity: ToastGravity.BOTTOM,
                                            //     backgroundColor:
                                            //         Colors.redAccent,
                                            //     textColor: Colors.white,
                                            //     fontSize: 16.0,
                                            //   );
                                            // }
                                          }
                                              : null,
                                          icon: Icon(
                                            Icons.add,
                                            size: 24,
                                            color: Colors.white.withOpacity(
                                              itemCubit
                                                      .paymentReceipt
                                                      .isNotEmpty
                                                  ? 1.0
                                                  : 0.5,
                                            ),
                                          ),
                                          label: Text(
                                            'save'.tr(),
                                            style: GoogleFonts.almarai(
                                              fontSize: getFontSize(
                                                context,
                                                18,
                                              ),
                                              color: Colors.white.withOpacity(
                                                itemCubit
                                                        .paymentReceipt
                                                        .isNotEmpty
                                                    ? 1.0
                                                    : 0.5,
                                              ),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                itemCubit
                                                        .paymentReceipt
                                                        .isNotEmpty
                                                    ? const Color(0xff2957CB)
                                                    : const Color(
                                                      0xff2957CB,
                                                    ).withOpacity(0.5),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                    fallback:
                                        (context) => const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 5.0,
                                            backgroundColor: Colors.black,
                                            color: Colors.blue,
                                            semanticsLabel:
                                                'Linear progress indicator',
                                          ),
                                        ),
                                  ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
