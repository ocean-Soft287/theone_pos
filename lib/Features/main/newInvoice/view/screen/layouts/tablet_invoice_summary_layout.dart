import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart' show Geolocator;
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Corec/local/chacheHelper.dart';
import 'package:theonepos/Features/main/InvoiceCollection/manager/invoice_collection_cubit.dart';
import 'package:theonepos/Features/main/InvoiceCollection/manager/invoice_collection_state.dart';

import 'package:theonepos/Features/main/newInvoice/manager/product_cubit.dart';

import 'package:theonepos/corec/sharde/consts.dart';
import 'package:theonepos/corec/sharde/font_responsive.dart';
import 'package:theonepos/corec/utils/widget/custom_field.dart';
import 'package:theonepos/corec/utils/widget/custom_text_field.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_state.dart';
import 'package:theonepos/Features/main/search/customer_search/screen/search_screen.dart';

import 'package:theonepos/main.dart';

class TabletInvoiceSummaryLayout extends StatelessWidget {
  ProductViewCubit itemCubit;
  final dynamic editInvoice;
  final int numofInvoice;

  TabletInvoiceSummaryLayout({
    super.key,
    required this.itemCubit,
    this.editInvoice,
    required this.numofInvoice,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductViewCubit>(context).fetchAndSendLocation(context);
    final currentLocale = context.locale;
    return BlocConsumer<ProductViewCubit, ProductState>(
      bloc: itemCubit,

      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<InvoiceCollectionCubit, InvoiceCollectionState>(
                builder: (context, state) {
                  InvoiceCollectionCubit itemBloc2 =
                      BlocProvider.of<InvoiceCollectionCubit>(context);

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 8,
                    ),
                    color: const Color(0xff5764EE),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * .4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'to_account'.tr(),
                                    style: GoogleFonts.almarai(
                                      color: Colors.white,
                                      fontSize: getFontSize(context, 14),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * .4,
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
                                        editInvoice != null
                                            ? '${editInvoice['CustomerName']}'
                                            : itemCubit.customerInfo != null
                                            ? '${itemCubit.customerInfo!['AcountName']}'
                                            : customer != null
                                            ? '${customer!['AcountName']}'
                                            : 'search_account'.tr(),
                                        style: GoogleFonts.almarai(
                                          fontSize: getFontSize(context, 14),
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
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
                                itemBloc2.getCompanyBranches(
                                  customerId: result['AccountID'],
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xfffa4f4e7),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'search'.tr(),
                                style: GoogleFonts.almarai(
                                  fontSize: getFontSize(context, 16),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              5.verticalSpace,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (accessHaveDiscount == 0)
                        Text(
                          'total'.tr(),
                          style: GoogleFonts.almarai(
                            color: const Color(0xff29568C),
                            fontWeight: FontWeight.bold,
                            fontSize: getFontSize(context, 14),
                          ),
                        ),
                      Material(
                        animationDuration: const Duration(milliseconds: 5),
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 100,
                          width: MediaQuery.sizeOf(context).width * .20,
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              itemCubit.total.toStringAsFixed(3),
                              style: GoogleFonts.almarai(
                                fontSize: getFontSize(context, 15),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (accessHaveDiscount == 1)
                    Column(
                      children: [
                        Text(
                          'discount'.tr(),
                          style: GoogleFonts.almarai(
                            color: const Color(0xff29568C),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
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
                  if (accessHaveDiscount == 1)
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * .14,
                          height: 60,

                          padding: const EdgeInsets.all(8),

                          child: Center(
                            child: CustomField(
                              controller: itemCubit.discountValue,
                              onChanged: (value) {
                                final discountValue =
                                    value.isNotEmpty ? num.parse(value) : 0;

                                itemCubit.updateFinalValue(
                                  discountValue: discountValue,
                                  totaleValue: itemCubit.total,
                                );

                                itemCubit.discountPercentage.text =
                                    ((discountValue / itemCubit.total) * 100)
                                        .toStringAsFixed(2);
                                itemCubit.getFinalValue(
                                  finalVal: itemCubit.finalValue,
                                );
                              },

                              textColor: Colors.black,
                              hintText: '',
                              enableColor: Colors.black,
                              fillColor: Colors.grey.withOpacity(0.1),
                              borderColor: Colors.black,
                              focusedColor: Colors.orange,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * .14,
                          height: 60,

                          padding: const EdgeInsets.all(8),

                          child: Center(
                            child: CustomField(
                              controller: itemCubit.additionValue,

                              onChanged: (value) {
                                final additionValue =
                                    value.isNotEmpty ? num.parse(value) : 0;

                                itemCubit.additionFinalValue(
                                  additionValue: additionValue,
                                  totaleValue: itemCubit.total,
                                );

                                itemCubit.additionPercentage.text =
                                    ((additionValue / itemCubit.total) * 100)
                                        .toStringAsFixed(2);

                                itemCubit.getFinalValue(
                                  finalVal: itemCubit.finalValue,
                                );
                              },
                              textColor: Colors.black,
                              hintText: '${0}',
                              enableColor: Colors.black,
                              fillColor: Colors.grey.withOpacity(0.1),
                              borderColor: Colors.black,
                              focusedColor: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (accessHaveDiscount == 1)
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * .14,
                          height: 60,
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomField(
                                    controller: itemCubit.discountPercentage,

                                    onChanged: (value) {
                                      final discountPercentage =
                                          value.isNotEmpty
                                              ? num.parse(value)
                                              : 0;

                                      itemCubit.discountPercentFinalValue(
                                        discountPercentage: discountPercentage,
                                        totaleValue: itemCubit.total,
                                      );

                                      itemCubit
                                          .discountValue
                                          .text = ((discountPercentage / 100) *
                                              itemCubit.total)
                                          .toStringAsFixed(2);

                                      itemCubit.getFinalValue(
                                        finalVal: itemCubit.finalValue,
                                      );
                                    },
                                    textColor: Colors.black,
                                    hintText: '${0}',
                                    enableColor: Colors.black,
                                    fillColor: Colors.grey.withOpacity(0.1),
                                    borderColor: Colors.black,
                                    focusedColor: Colors.orange,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '%',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getFontSize(context, 16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * .14,
                          height: 60,
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: CustomField(
                                      controller: itemCubit.additionPercentage,

                                      onChanged: (value) {
                                        final additionPercentage =
                                            value.isNotEmpty
                                                ? num.parse(value)
                                                : 0;

                                        itemCubit.addPercentFinalValue(
                                          addPercentage: additionPercentage,
                                          totaleValue: itemCubit.total,
                                        );

                                        itemCubit.additionValue.text =
                                            ((additionPercentage / 100) *
                                                    itemCubit.total)
                                                .toStringAsFixed(2);

                                        itemCubit.getFinalValue(
                                          finalVal: itemCubit.finalValue,
                                        );
                                      },
                                      textColor: Colors.black,
                                      hintText: '${0}',
                                      enableColor: Colors.black,
                                      fillColor: Colors.grey.withOpacity(0.1),
                                      borderColor: Colors.black,
                                      focusedColor: Colors.orange,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '%',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getFontSize(context, 16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (accessHaveDiscount == 0)
                        Text(
                          'net'.tr(),
                          style: GoogleFonts.almarai(
                            color: const Color(0xff29568C),
                            fontWeight: FontWeight.bold,
                            fontSize: getFontSize(context, 14),
                          ),
                        ),
                      Material(
                        animationDuration: const Duration(milliseconds: 5),
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 100,
                          width: MediaQuery.sizeOf(context).width * .20,
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              (itemCubit.finalValue == 0.0)
                                  ? itemCubit.total.toStringAsFixed(3)
                                  : itemCubit.finalValue.toStringAsFixed(3),
                              style: GoogleFonts.almarai(
                                fontSize: getFontSize(context, 15),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                'notes'.tr(),
                style: GoogleFonts.almarai(
                  color: const Color(0xff45596B),
                  fontSize: getFontSize(context, 16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.verticalSpace,
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextField(
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: 'enter_description_here'.tr(),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 16,
                    ), // Padding داخلي
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * .45,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff53BDF5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          textColor: Colors.black,
                          hintColor: Colors.black,
                          labelText: 'paid'.tr(),
                          labelColor: Colors.black,
                          hintText: (itemCubit.sumUnPaid).toStringAsFixed(3),
                          enableColor: Colors.black,
                          fillColor: Colors.white,
                          borderColor: Colors.black,
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

                        CustomTextField(
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
                          enableColor: Colors.black,
                          fillColor: Colors.white,
                          borderColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .45,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff53BDF5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          hintColor: Colors.black,
                          textColor: Colors.black,
                          readOnly: true,
                          labelText: 'total_quantity'.tr(),
                          labelColor: Colors.black,
                          hintText: '${itemCubit.quantityf}',
                          enableColor: Colors.black,
                          fillColor: Colors.white,
                          borderColor: Colors.black,
                        ),

                        CustomTextField(
                          hintColor: Colors.black,
                          textColor: Colors.black,
                          readOnly: true,
                          labelText: 'item_count'.tr(),
                          labelColor: Colors.black,
                          hintText: '${itemCubit.itemList.length}',
                          enableColor: Colors.black,
                          fillColor: Colors.white,
                          borderColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              8.verticalSpace,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'payment_method'.tr(),
                          style: GoogleFonts.almarai(
                            color: Colors.black,
                            fontSize: getFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<
                          InvoiceCollectionCubit,
                          InvoiceCollectionState
                        >(
                          builder: (context, state) {
                            InvoiceCollectionCubit itemBloc2 =
                                BlocProvider.of<InvoiceCollectionCubit>(
                                  context,
                                );
                            BlocProvider.of<ProductViewCubit>(
                              context,
                            ).loadPatternIDFromCache();
                            // تصفية قائمة طرق الدفع بناءً على قيمة accessHaveDiscount
                            List<Map<String, dynamic>> filteredPayWaysList =
                            accessHaveDiscount != 1
                                ? itemBloc2.payWaysList.toList()
                            // itemBloc2.payWaysList
                            // .where((item) =>  item['Code_PW'] == 1)
                            // .toList()
                                :                                        itemBloc2.payWaysList.toList();
                            //     : itemBloc2.payWaysList;

                            return filteredPayWaysList.isEmpty
                                ? const SizedBox.shrink()
                                : DropdownButtonFormField<Map<String, dynamic>>(
                                  value: null,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'payment_method'.tr(),
                                    hintStyle: GoogleFonts.almarai(
                                      color: const Color(0xff333333),
                                      fontSize: getFontSize(context, 14),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  items:
                                      filteredPayWaysList.map((
                                        Map<String, dynamic> item,
                                      ) {
                                        return DropdownMenuItem<
                                          Map<String, dynamic>
                                        >(
                                          value: item,
                                          child: Text(
                                            (currentLocale.languageCode == 'ar')
                                                ? item['Name_PW'] ??
                                                    'unknown'.tr()
                                                : item['EName_PW'] ??
                                                    'unknown'.tr(),
                                            style: GoogleFonts.almarai(
                                              color: const Color(0xff333333),
                                              fontSize: getFontSize(
                                                context,
                                                14,
                                              ),
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
                                    }
                                    if (newValue!['Code_PW'] == 0) {
                                      itemCubit.totalValue.text = itemCubit
                                          .total
                                          .toStringAsFixed(3);
                                    }
                                    itemCubit.receiptNumber.text = '';
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

                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .3,
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
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .2,

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
                          fontSize: getFontSize(context, 18),
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
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
                    Container(width: 1, height: 30, color: Colors.white),
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
                    Container(width: 1, height: 30, color: Colors.white),
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
                        padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                        (currentLocale.languageCode == 'ar')
                                            ? itemCubit
                                                .paymentReceipt[index]['PayWayName']
                                            : itemCubit
                                                .paymentReceipt[index]['PayWayEnName'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
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
                                        '${itemCubit.paymentReceipt[index]['PayingValue']}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
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
                                        '${itemCubit.paymentReceipt[index]['receiptNumber']}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: getFontSize(context, 14),
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
                                      itemCubit.deleteReceipt(index: index);
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
                  width: MediaQuery.sizeOf(context).width * .2,
                  child:
                      (editInvoice != null)
                          ? ConditionalBuilder(
                            condition: itemCubit.state is! EditeOrderLoading,
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
                                      fontSize: getFontSize(context, 18),
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
                                      borderRadius: BorderRadius.circular(
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
                                    semanticsLabel: 'Linear progress indicator',
                                  ),
                                ),
                          )
                          : ConditionalBuilder(
                            condition: itemCubit.state is! AddOrderLoading,
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
                                      itemCubit.paymentReceipt.isNotEmpty
                                          ? 1.0
                                          : 0.5,
                                    ),
                                  ),
                                  label: Text(
                                    'save'.tr(),
                                    style: GoogleFonts.almarai(
                                      fontSize: getFontSize(context, 18),
                                      color: Colors.white.withOpacity(
                                        itemCubit.paymentReceipt.isNotEmpty
                                            ? 1.0
                                            : 0.5,
                                      ),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        itemCubit.paymentReceipt.isNotEmpty
                                            ? const Color(0xff2957CB)
                                            : const Color(
                                              0xff2957CB,
                                            ).withOpacity(0.5),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                            fallback:
                                (context) => const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 5.0,
                                    backgroundColor: Colors.black,
                                    color: Colors.blue,
                                    semanticsLabel: 'Linear progress indicator',
                                  ),
                                ),
                          ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
