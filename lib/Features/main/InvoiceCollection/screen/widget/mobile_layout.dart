import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../corec/sharde/font_responsive.dart';
import '../../../../../corec/utils/widget/custom_text_field.dart';
import '../../../../../corec/utils/widget/data_picker.dart';
import '../../../../../main.dart' show accessHaveDiscount;
import '../../../search/customer_search/screen/search_screen.dart';
import '../../../search/invoice_search/screen/invoice_search_screen.dart';
import '../../manager/invoice_collection_cubit.dart';
import '../../manager/invoice_collection_state.dart';

class MobileLayout extends StatelessWidget {
  final dynamic editCollection;

  const MobileLayout({super.key, this.editCollection});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    String currentLanguageCode = currentLocale.languageCode;
    if (editCollection != null) {
      print(editCollection);

      BlocProvider.of<InvoiceCollectionCubit>(context).codePw =
          editCollection["Code_PW"];

      BlocProvider.of<InvoiceCollectionCubit>(context).currencyId =
          editCollection["CurrencyId"];
      BlocProvider.of<InvoiceCollectionCubit>(context).currencyRate =
          editCollection["CurrencyRate"];
      BlocProvider.of<InvoiceCollectionCubit>(context).voucherTypeId =
          editCollection["VoucherType"];
      BlocProvider.of<InvoiceCollectionCubit>(context)
          .nameTypeIdController
          .text = editCollection["BankAcName"].toString();
      BlocProvider.of<InvoiceCollectionCubit>(context).branchId =
          editCollection["BranchId"];
      BlocProvider.of<InvoiceCollectionCubit>(context)
          .voucherValueControlle
          .text = editCollection["VoucherValue"].toString();
      BlocProvider.of<InvoiceCollectionCubit>(context)
          .voucherValueControllerTwo
          .text = editCollection["VoucherValue"].toString();
      BlocProvider.of<InvoiceCollectionCubit>(context).noteController.text =
          editCollection["Notes"].toString();
      BlocProvider.of<InvoiceCollectionCubit>(context).creditAccount.text =
          editCollection["VoucherAccounts"][0]["AcName"].toString();
      BlocProvider.of<InvoiceCollectionCubit>(context).acId =
          editCollection["VoucherAccounts"][0]["AcId"];
      if (editCollection["VoucherAccounts"] != null &&
          editCollection["VoucherAccounts"].isNotEmpty) {
        BlocProvider.of<InvoiceCollectionCubit>(context).keyNetController.text =
            editCollection["VoucherAccounts"][0]["KeyNet"].toString() ??
            '0'.toString();
        BlocProvider.of<InvoiceCollectionCubit>(
              context,
            ).agreementNoController.text =
            editCollection["VoucherAccounts"][0]["AgreementNo"].toString() ??
            '0'.toString();
      }
    }
    return BlocConsumer<InvoiceCollectionCubit, InvoiceCollectionState>(
      listener: (context, state) {},
      builder: (context, state) {
        InvoiceCollectionCubit itemBloc =
            BlocProvider.of<InvoiceCollectionCubit>(context);
        List<Map<String, dynamic>> filteredPayWaysList =
            accessHaveDiscount != 1
                ?
            // itemBloc.payWaysList
            //         .where(
            //           (item) => item['Code_PW'] == 0 ,
            //   //|| item['Code_PW'] == 1,
            //         )
            itemBloc.payWaysList .toList()
                : itemBloc.payWaysList.toList();

        //      : itemBloc.payWaysList;
        return Form(
          key: itemBloc.formKey,

          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xff006296),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'branch'.tr(),
                                style: GoogleFonts.almarai(
                                  color: Colors.white,
                                  fontSize: getFontSize(context, 16),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * .6,

                                child: DropdownSearch<Map<dynamic, dynamic>>(
                                  items: itemBloc.allCompanyBranchesList0,
                                  popupProps: const PopupProps.menu(
                                    showSelectedItems: false,
                                    showSearchBox: true,
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16.0,
                                                  ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                              ),
                                              hintText: "select_branch".tr(),
                                              hintStyle: const TextStyle(
                                                color: Color(0xff333333),
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                      ),
                                  onChanged: (
                                    Map<dynamic, dynamic>? selectedItem,
                                  ) {
                                    if (selectedItem != null) {
                                      itemBloc.updateBranchId(
                                        newData: selectedItem["ID"],
                                      );
                                    }
                                  },
                                  selectedItem:
                                      editCollection != null &&
                                              itemBloc
                                                  .allCompanyBranchesList0
                                                  .isNotEmpty
                                          ? itemBloc.allCompanyBranchesList0
                                              .firstWhere(
                                                (branch) =>
                                                    branch["ID"] ==
                                                    editCollection["BranchId"],
                                                orElse:
                                                    () =>
                                                        itemBloc
                                                            .allCompanyBranchesList0[0],
                                              )
                                          : (itemBloc
                                                  .allCompanyBranchesList0
                                                  .isNotEmpty
                                              ? itemBloc
                                                  .allCompanyBranchesList0[0]
                                              : null),

                                  itemAsString: (Map<dynamic, dynamic>? item) {
                                    return item != null
                                        ? (currentLanguageCode == 'ar'
                                                ? item['BraName']
                                                : item['BraEName']) ??
                                            ''
                                        : '';
                                  },
                                  dropdownBuilder: (
                                    context,
                                    Map<dynamic, dynamic>? selectedItem,
                                  ) {
                                    return Text(
                                      selectedItem != null
                                          ? (currentLanguageCode == 'ar'
                                                  ? selectedItem['BraName']
                                                  : selectedItem['BraEName']) ??
                                              "اختر الفرع"
                                          : "select_branch".tr(),
                                      style: GoogleFonts.almarai(
                                        color: const Color(0xff333333),
                                        fontSize: getFontSize(context, 16),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    );
                                  },
                                  clearButtonProps: const ClearButtonProps(
                                    isVisible: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'date'.tr(),
                              style: GoogleFonts.almarai(
                                color: Colors.white,
                                fontSize: getFontSize(context, 16),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            2.verticalSpace,
                            DatePickerWidget(
                              widthH: MediaQuery.sizeOf(context).width * .3,

                              onDateSelected: (DateTime? selectedDate) {
                                itemBloc.CreationDateTime = DateFormat(
                                  'dd/MM/yyyy',
                                  'en_US',
                                ).format(selectedDate!.toLocal());
                              },
                              fillColor: const Color(0xffE7EBEF),
                              heightH: 43.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .6,
                          child: CustomTextField(
                            readOnly: true,
                            labelText: 'credit_account'.tr(),
                            hintText: itemBloc.creditAccount.text,
                            enableColor: Colors.white,
                            focusedColor: Colors.lightGreenAccent,
                            controller: itemBloc.creditAccount,
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .3,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ),
                              );
                              itemBloc.acId = result['AccountID'];

                              itemBloc.updateCreditAccount(
                                blance: result['AcountName'],
                                newData: result['AcountName'],
                              );
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 24,
                              color: Colors.white,
                            ),
                            label: Text(
                              'search'.tr(),
                              style: GoogleFonts.almarai(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff186FDC),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .45,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'collection_method'.tr(),
                                style: GoogleFonts.almarai(
                                  color: Colors.white,
                                  fontSize: getFontSize(context, 16),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              filteredPayWaysList.isEmpty
                                  ? const SizedBox.shrink()
                                  : DropdownButtonFormField<
                                    Map<String, dynamic>
                                  >(
                                    value:
                                        filteredPayWaysList.isNotEmpty
                                            ? filteredPayWaysList.firstWhere(
                                              (element) =>
                                                  element['Code_PW'] == 0,
                                              orElse:
                                                  () =>
                                                      filteredPayWaysList
                                                          .first, // Provide a fallback value
                                            )
                                            : null, // Ensure initial value matches an item or set it to null
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
                                      hintText: 'payment_method'.tr(),
                                      hintStyle: GoogleFonts.almarai(
                                        color: const Color(0xff333333),
                                        fontSize: getFontSize(context, 14),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                items: filteredPayWaysList.map(
                                      (Map<String, dynamic> item) {
                                    return DropdownMenuItem<Map<String, dynamic>>(
                                      value: item,
                                      child: Text(
                                        (currentLocale.languageCode == 'ar')
                                            ? item['Name_PW'] ?? 'unknown'.tr()
                                            : item['EName_PW'] ?? 'unknown'.tr(),
                                        style: GoogleFonts.almarai(
                                          color: const Color(0xff333333),
                                          fontSize: getFontSize(context, 14),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                    /// Returns all items
                                        // filteredPayWaysList.map((
                                        //   Map<String, dynamic> item,
                                        // ) {
                                        //   // Ensure each `value` is unique in DropdownMenuItem
                                        //   return DropdownMenuItem<
                                        //     Map<String, dynamic>
                                        //   >(
                                        //     value:
                                        //         item, // Ensure value is unique
                                        //     child: Text(
                                        //       (currentLocale.languageCode ==
                                        //               'ar')
                                        //           ? item['Name_PW'] ??
                                        //               'unknown'.tr()
                                        //           : item['EName_PW'] ??
                                        //               'unknown'.tr(),
                                        //       style: GoogleFonts.almarai(
                                        //         color: const Color(0xff333333),
                                        //         fontSize: getFontSize(
                                        //           context,
                                        //           14,
                                        //         ),
                                        //         fontWeight: FontWeight.w400,
                                        //       ),
                                        //     ),
                                        //   );
                                        // }).toList(),

                                    onChanged: (
                                      Map<String, dynamic>? newValue,
                                    ) {
                                      if (newValue != null) {
                                        itemBloc.updateCodePay(
                                          newData: newValue['Code_PW'],
                                        );

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
                                  ),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'currency'.tr(),
                                style: GoogleFonts.almarai(
                                  color: Colors.white,
                                  fontSize: getFontSize(context, 16),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              DropdownButtonFormField<Map<String, dynamic>>(
                                value:
                                    editCollection != null &&
                                            itemBloc
                                                .allCurrenciesList
                                                .isNotEmpty
                                        ? itemBloc.allCurrenciesList.firstWhere(
                                          (currency) =>
                                              currency['CurrencyID'] ==
                                              editCollection["CurrencyId"],
                                          orElse:
                                              () =>
                                                  itemBloc.allCurrenciesList[0],
                                        )
                                        : (itemBloc.allCurrenciesList.isNotEmpty
                                            ? itemBloc.allCurrenciesList[0]
                                            : null),

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
                                  hintText: 'currency'.tr(),
                                  hintStyle: GoogleFonts.almarai(
                                    color: const Color(0xff333333),
                                    fontSize: getFontSize(context, 14),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                items:
                                    itemBloc.allCurrenciesList.map((
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
                                            color: const Color(0xff333333),
                                            fontSize: getFontSize(context, 14),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (Map<String, dynamic>? newValue) {
                                  if (newValue != null) {
                                    itemBloc.updateCurrencyId(
                                      newData: newValue['CurrencyID'],
                                    );
                                    itemBloc.updateCurrencyRate(
                                      newData: newValue['Rate'],
                                    );
                                    itemBloc.rateController.text =
                                        newValue['Rate'].toString();
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .45,
                          child: CustomTextField(
                            readOnly: true,
                            labelText: 'disbursement'.tr(),
                            hintText: '${itemBloc.currencyRate}',
                            enableColor: Colors.white,
                            focusedColor: Colors.lightGreenAccent,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .45,
                          child: CustomTextField(
                            readOnly: true,
                            labelText: 'equivalent'.tr(),
                            hintText:
                                (itemBloc.currencyRate != 0 &&
                                        itemBloc.currencyRate.isFinite)
                                    ? (1 / itemBloc.currencyRate)
                                        .toStringAsFixed(3)
                                    : "0",
                            enableColor: Colors.white,
                            focusedColor: Colors.lightGreenAccent,
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
                          width: MediaQuery.sizeOf(context).width * .45,
                          child: CustomTextField(
                            readOnly: true,
                            labelText: 'local_value'.tr(),
                            hintText: itemBloc.voucherValueControlle.text,
                            enableColor: Colors.white,
                            focusedColor: Colors.lightGreenAccent,
                            controller: itemBloc.voucherValueControlle,
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .45,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InvoiceSearchScreen(),
                                ),
                              );

                              itemBloc.acId = result['CustomerID'];

                              itemBloc.updateVoucher(
                                invoiceId: result['InvoiceID'],
                                invoiceNO: result['InvoiceNo'],
                                newData: result['TotalValue'],
                                newDataTwo: result['TotalValue'],
                              );

                              itemBloc.updateCreditAccount(
                                blance: result['CustomerName'],
                                newData: result['CustomerName'],
                              );
                            },
                            icon: const Icon(
                              Icons.receipt_long,
                              size: 24,
                              color: Colors.white,
                            ),
                            label: Text(
                              'in_voice'.tr(),
                              style: GoogleFonts.almarai(
                                fontSize: getFontSize(context, 14),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff186FDC),
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
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0xffEDF3FB),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 1,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'type_of_receipt'.tr(),
                            style: GoogleFonts.almarai(
                              color: Colors.black,
                              fontSize: getFontSize(context, 16),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          DropdownButtonFormField<Map<String, dynamic>>(
                            value:
                                itemBloc.allBoundsTypeList.isNotEmpty
                                    ? itemBloc.allBoundsTypeList[0]
                                    : null, // Set to the first item
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
                              hintText: 'type_of_receipt'.tr(),
                              hintStyle: GoogleFonts.almarai(
                                color: const Color(0xff333333),
                                fontSize: getFontSize(context, 14),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            items:
                                itemBloc.allBoundsTypeList.map((
                                  Map<String, dynamic> item,
                                ) {
                                  return DropdownMenuItem<Map<String, dynamic>>(
                                    value:
                                        item, // Set the value to the entire map
                                    child: Text(
                                      (currentLanguageCode == 'ar')
                                          ? item['ArabicName'] ?? 'unknown'.tr()
                                          : item['EnglishName'] ??
                                              'unknown'.tr(),
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
                                itemBloc.updateVoucherTypeId(
                                  newData:
                                      (currentLanguageCode == 'ar')
                                          ? newValue['CustomerName'] ?? ''
                                          : newValue['CustomerEnName'] ?? '',
                                  customerID: newValue['VoucherType'],
                                );
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
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 1,
                      child: CustomTextField(
                        readOnly: true,
                        labelColor: const Color(0xff45596B),
                        labelText: '',
                        hintText: itemBloc.nameTypeIdController.text,
                        controller: itemBloc.nameTypeIdController,
                        enableColor: Colors.white,
                        focusedColor: Colors.lightGreenAccent,
                      ),
                    ),
                    8.verticalSpace,
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 1,
                      child: CustomTextField(
                        labelColor: const Color(0xff45596B),
                        labelText: 'local_value'.tr(),
                        hintText: '0',
                        controller: itemBloc.voucherValueControllerTwo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'field_required'.tr();
                          }
                          return null; // إذا كانت القيمة صحيحة
                        },
                      ),
                    ),
                    8.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .45,
                          child: CustomTextField(
                            labelColor: const Color(0xff45596B),
                            labelText: 'knet_number'.tr(),
                            hintText: '0',
                            controller: itemBloc.keyNetController,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .45,
                          child: CustomTextField(
                            labelColor: const Color(0xff45596B),
                            labelText: 'approval_number'.tr(),
                            hintText: '0',
                            controller: itemBloc.agreementNoController,
                          ),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .45,
                          child: CustomTextField(
                            labelColor: const Color(0xff45596B),
                            labelText: 'check_number'.tr(),
                            hintText: '0',
                            controller: itemBloc.checkNumberController,
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'due_date'.tr(),
                                style: GoogleFonts.almarai(
                                  color: const Color(0xff45596B),
                                  fontSize: getFontSize(context, 16),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),

                              DatePickerWidget(
                                onDateSelected: (DateTime? selectedDate) {
                                  itemBloc.CheckDueDate = DateFormat(
                                    'dd/MM/yyyy',
                                    'en_US',
                                  ).format(selectedDate!.toLocal());
                                },
                                fillColor: const Color(0xff006296),
                                heightH: 42.h,
                                widthH: MediaQuery.sizeOf(context).width,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    10.verticalSpace,
                    Text(
                      'description'.tr(),
                      style: GoogleFonts.almarai(
                        color: const Color(0xff45596B),
                        fontSize: getFontSize(context, 15),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    5.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        controller: itemBloc.noteController,
                        decoration: InputDecoration(
                          hintText: 'enter_description_here'.tr(),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true, // خلفية بيضاء
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 5,
                          ), // Padding داخلي
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .4,
                          child: ConditionalBuilder(
                            condition:
                                BlocProvider.of<InvoiceCollectionCubit>(
                                      context,
                                    ).state
                                    is! AddInvoiceCollectingLoading,
                            builder:
                                (context) => ElevatedButton(
                                  onPressed: () {
                                    if (editCollection != null) {
                                      itemBloc.editInvoiceCollecting(
                                        branchId: itemBloc.branchId,
                                        codePw: itemBloc.codePw,
                                        currencyId: itemBloc.currencyId,
                                        currencyRate: itemBloc.currencyRate,
                                        voucherTypeId: itemBloc.voucherTypeId,
                                        context: context,
                                        voucherNumber:
                                            editCollection["VoucherNumber"],
                                        invoiceID: editCollection["InvoiceID"],
                                        invoiceNo: editCollection["InvoiceNo"],
                                        CreationDateTime:
                                            itemBloc.CreationDateTime,
                                        CheckDueDate: itemBloc.CheckDueDate,
                                        notes: itemBloc.noteController.text,
                                        checkNumber:
                                            (itemBloc
                                                    .checkNumberController
                                                    .text
                                                    .isEmpty)
                                                ? '0'
                                                : itemBloc
                                                    .checkNumberController
                                                    .text,
                                        agreementNo:
                                            (itemBloc
                                                    .agreementNoController
                                                    .text
                                                    .isEmpty)
                                                ? '0'
                                                : itemBloc
                                                    .agreementNoController
                                                    .text,
                                        keyNet:
                                            (itemBloc
                                                    .keyNetController
                                                    .text
                                                    .isEmpty)
                                                ? '0'
                                                : itemBloc
                                                    .keyNetController
                                                    .text,
                                        acId: itemBloc.acId ?? 1,
                                      );
                                    } else {
                                      if (itemBloc.voucherTypeId == 1) {
                                        itemBloc.addInvoiceCollecting(
                                          context: context,
                                          CreationDateTime:
                                              itemBloc.CreationDateTime,
                                          CheckDueDate: itemBloc.CheckDueDate,
                                          notes: itemBloc.noteController.text,
                                          checkNumber:
                                              itemBloc
                                                  .checkNumberController
                                                  .text,
                                          agreementNo: '0',
                                          keyNet: '0',
                                          acId: itemBloc.acId ?? 1,
                                        );
                                      } else {
                                        if (itemBloc.formKey.currentState !=
                                            null) {
                                          itemBloc.addInvoiceCollecting(
                                            context: context,
                                            CreationDateTime:
                                                itemBloc.CreationDateTime,
                                            CheckDueDate: itemBloc.CheckDueDate,
                                            notes: itemBloc.noteController.text,
                                            checkNumber:
                                                (itemBloc
                                                        .checkNumberController
                                                        .text
                                                        .isEmpty)
                                                    ? '0'
                                                    : itemBloc
                                                        .checkNumberController
                                                        .text,
                                            agreementNo:
                                                (itemBloc
                                                        .agreementNoController
                                                        .text
                                                        .isEmpty)
                                                    ? '0'
                                                    : itemBloc
                                                        .agreementNoController
                                                        .text,
                                            keyNet:
                                                (itemBloc
                                                        .keyNetController
                                                        .text
                                                        .isEmpty)
                                                    ? '0'
                                                    : itemBloc
                                                        .keyNetController
                                                        .text,
                                            acId: itemBloc.acId ?? 1,
                                          );
                                          if (itemBloc
                                                  .keyNetController
                                                  .text
                                                  .isEmpty ||
                                              itemBloc
                                                  .checkNumberController
                                                  .text
                                                  .isEmpty) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'أحد الحقول لم يتم إدخال قيم، ولكن يمكنك المتابعة.',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                  ), // يمكنك تعديل التنسيق حسب الرغبة
                                                  textAlign: TextAlign.center,
                                                ),
                                                backgroundColor: Colors.orange,
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 16.0,
                                    ),
                                    backgroundColor:
                                        (editCollection != null)
                                            ? Colors.orange
                                            : const Color(0xff1E40AF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Text(
                                    'sa_va'.tr(),
                                    style: GoogleFonts.almarai(
                                      fontSize: getFontSize(context, 16),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
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
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .4,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 16.0,
                              ),
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: Text(
                              'cancel'.tr(),
                              style: GoogleFonts.almarai(
                                fontSize: getFontSize(context, 16),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
