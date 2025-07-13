import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/corec/sharde/font_responsive.dart';
import 'package:theonepos/Features/main/InvoiceCollection/screen/widget/component/component_info_diaplay.dart';

import '../../../../../corec/utils/widget/custom_text_field.dart';
import '../../../../../corec/utils/widget/data_picker.dart';
import '../../../../../main.dart';
import '../../../search/customer_search/screen/search_screen.dart';
import '../../../search/invoice_search/screen/invoice_search_screen.dart';
import '../../manager/invoice_collection_cubit.dart';
import '../../manager/invoice_collection_state.dart';

class TabletLayout extends StatefulWidget {
  final dynamic editCollection;

  const TabletLayout({super.key, this.editCollection});

  @override
  State<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> {
  double result = 0.0;

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    String currentLanguageCode = currentLocale.languageCode;
    if (widget.editCollection != null) {
      print(widget.editCollection);
      BlocProvider.of<InvoiceCollectionCubit>(context).codePw =
      widget.editCollection["Code_PW"];
      BlocProvider.of<InvoiceCollectionCubit>(context).currencyId =
      widget.editCollection["CurrencyId"];
      BlocProvider.of<InvoiceCollectionCubit>(context).currencyRate =
      widget.editCollection["CurrencyRate"];
      BlocProvider.of<InvoiceCollectionCubit>(context).voucherTypeId =
      widget.editCollection["VoucherType"];
      BlocProvider.of<InvoiceCollectionCubit>(context)
          .nameTypeIdController
          .text = widget.editCollection["BankAcName"].toString();
      BlocProvider.of<InvoiceCollectionCubit>(context).branchId =
      widget.editCollection["BranchId"];
      BlocProvider.of<InvoiceCollectionCubit>(context)
          .voucherValueControlle
          .text = widget.editCollection["VoucherValue"].toString();
      BlocProvider.of<InvoiceCollectionCubit>(context)
          .voucherValueControllerTwo
          .text = widget.editCollection["VoucherValue"].toString();
      BlocProvider.of<InvoiceCollectionCubit>(context).noteController.text =
          widget.editCollection["Notes"].toString();
      BlocProvider.of<InvoiceCollectionCubit>(context).creditAccount.text =
          widget.editCollection["VoucherAccounts"][0]["AcName"].toString();
      BlocProvider.of<InvoiceCollectionCubit>(context).acId =
      widget.editCollection["VoucherAccounts"][0]["AcId"];
      if (widget.editCollection["VoucherAccounts"] != null &&
          widget.editCollection["VoucherAccounts"].isNotEmpty) {
        BlocProvider.of<InvoiceCollectionCubit>(context).keyNetController.text =
            widget.editCollection["VoucherAccounts"][0]["KeyNet"].toString() ??
                '0'.toString();
        BlocProvider.of<InvoiceCollectionCubit>(context)
            .agreementNoController
            .text = widget.editCollection["VoucherAccounts"][0]["AgreementNo"]
            .toString() ??
            '0'.toString();
      }
    }
    return BlocConsumer<InvoiceCollectionCubit, InvoiceCollectionState>(
      builder: (context, state) {
        InvoiceCollectionCubit itemBloc =
        BlocProvider.of<InvoiceCollectionCubit>(context);
        List<Map<String, dynamic>> filteredPayWaysList =
        accessHaveDiscount != 1
            ?
        // itemBloc.payWaysList
        // .where(
        //   (item) => item['Code_PW'] == 0,
        //       // || item['Code_PW'] == 1,
        // )
        itemBloc.payWaysList    .toList()
            : itemBloc.payWaysList  .toList();
        itemBloc.payWaysList;
        //  itemBloc.payWaysList;
        return Form(
          key: itemBloc.formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0xff006296),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'branch'.tr(),
                                style: GoogleFonts.almarai(
                                  color: Colors.white,
                                  fontSize: getFontSize(context, 14),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * .4,
                                height: 45,
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
                                  widget.editCollection != null
                                      ? itemBloc.allCompanyBranchesList0
                                      .firstWhere(
                                        (branch) =>
                                    branch["ID"] ==
                                        widget
                                            .editCollection["BranchId"],
                                  )
                                      : null,
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
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'date'.tr(),
                                style: GoogleFonts.almarai(
                                  color: Colors.white,
                                  fontSize: getFontSize(context, 14),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              2.verticalSpace,
                              DatePickerWidget(
                                fillColor: const Color(0xffE7EBEF),
                                heightH: 45,
                                widthH:
                                MediaQuery.of(context).size.width * 0.25,
                                onDateSelected: (DateTime? selectedDate) {
                                  print(
                                    "Selected date: ${DateFormat('yyyy/MM/dd', 'en_US').format(selectedDate!)}",
                                  );
                                  DateTime dateToFormat =
                                      selectedDate ?? DateTime.now();
                                  itemBloc.CreationDateTime =
                                      itemBloc.CreationDateTime ??
                                          DateFormat(
                                            'yyyy/MM/dd',
                                            'en_US',
                                          ).format(DateTime.now());
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: ComponentInfoDisplay(
                            widthW: MediaQuery.sizeOf(context).width * .2,
                            label: 'stock'.tr(),
                            value: ' ${itemBloc.blancee ?? 0}  ',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: 45,
                          child:
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
                            items:
                            filteredPayWaysList.map((
                                Map<String, dynamic> item,
                                ) {
                              return DropdownMenuItem<
                                  Map<String, dynamic>
                              >(
                                value:
                                item, // Ensure value is unique
                                child: Text(
                                  (currentLocale.languageCode ==
                                      'ar')
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
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.25,
                          height: 45,
                          child: DropdownButtonFormField<Map<String, dynamic>>(
                            value:
                            widget.editCollection != null &&
                                itemBloc.allCurrenciesList.isNotEmpty
                                ? itemBloc.allCurrenciesList.firstWhere(
                                  (currency) =>
                              currency['CurrencyID'] ==
                                  widget.editCollection["CurrencyId"],
                              orElse:
                                  () => itemBloc.allCurrenciesList[0],
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
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: item,
                                child: Text(
                                  currentLanguageCode == 'ar'
                                      ? (item['CurrencyName'] ??
                                      'غير معروف') // اسم العملة بالعربية
                                      : (item['CurrencyEName'] ??
                                      'Unknown'), // اسم العملة بالإنجليزية
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
                            style: GoogleFonts.almarai(
                              color: const Color(0xff333333),
                              fontSize: getFontSize(context, 16),
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
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: CustomTextField(
                            readOnly: true,
                            labelText: 'expenses'.tr(),
                            hintText: '${itemBloc.currencyRate}',
                            enableColor: Colors.white,
                            focusedColor: Colors.lightGreenAccent,
                            controller: itemBloc.rateController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .4,
                          child: CustomTextField(
                            readOnly: true,
                            labelText: 'المكافى',
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
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .25,
                          child: CustomTextField(
                            labelText: 'local_value'.tr(),
                            readOnly: true,
                            hintText: itemBloc.voucherValueControlle.text,
                            enableColor: Colors.white,
                            focusedColor: Colors.lightGreenAccent,
                            controller: itemBloc.voucherValueControlle,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InvoiceSearchScreen(),
                                ),
                              );

                              itemBloc.updateVoucher(
                                invoiceId: result['InvoiceID'],
                                invoiceNO: result['InvoiceNo'],
                                newData: result['TotalValue'],
                                newDataTwo: result['TotalValue'],
                              );
                              itemBloc.acId = result['CustomerID'];

                              itemBloc.updateCreditAccount(
                                blance: result['Remainder'],
                                newData: result['CustomerName'],
                              );
                            },
                            icon: const Icon(
                              Icons.receipt_long,
                              size: 24,
                              color: Colors.white,
                            ),
                            label: Text(
                              'invoice'.tr(),
                              style: GoogleFonts.almarai(
                                fontSize: getFontSize(context, 16),
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
                    const SizedBox(width: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .67,
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
                          width: MediaQuery.sizeOf(context).width * .2,
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
                                blance: result['Balance'],
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
                                fontSize: getFontSize(context, 16),
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
                    10.verticalSpace,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 50,
                          child: DropdownButtonFormField<Map<String, dynamic>>(
                            value:
                            widget.editCollection != null &&
                                itemBloc.allBoundsTypeList.isNotEmpty
                                ? itemBloc.allBoundsTypeList.firstWhere(
                                  (boundsType) =>
                              boundsType['VoucherType'] ==
                                  widget.editCollection["VoucherType"],
                              orElse:
                                  () => itemBloc.allBoundsTypeList[0],
                            )
                                : (itemBloc.allBoundsTypeList.isNotEmpty
                                ? itemBloc.allBoundsTypeList[0]
                                : null), // Set to the first item
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
                              hintText:
                              'type_of_receipt'.tr(), // Use translation
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
                                  currentLanguageCode == 'ar'
                                      ? (item['ArabicName'] ??
                                      'غير معروف') // عرض الاسم بالعربية
                                      : (item['EnglishName'] ??
                                      'Unknown'), // عرض الاسم بالإنجليزية
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
                                  currentLanguageCode == 'ar'
                                      ? newValue['CustomerName']
                                      : newValue['CustomerEnName'],
                                  customerID: newValue['VoucherType'],
                                );
                              }
                            },
                            style: GoogleFonts.almarai(
                              color: const Color(0xff333333),
                              fontSize: getFontSize(context, 16),
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
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .55,
                          child: CustomTextField(
                            readOnly: true,
                            labelColor: const Color(0xff45596B),
                            labelText: '',
                            hintText: itemBloc.nameTypeIdController.text,
                            controller: itemBloc.nameTypeIdController,
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .25,
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
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .25,
                          child: CustomTextField(
                            labelColor: const Color(0xff45596B),
                            labelText: 'approval_number'.tr(),
                            hintText: 'approval_number'.tr(),
                            controller: itemBloc.agreementNoController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field_required'.tr();
                              }
                              return null; // إذا كانت القيمة صحيحة
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .25,
                          child: CustomTextField(
                            labelColor: const Color(0xff45596B),
                            labelText: 'knet_number'.tr(),
                            hintText: 'knet_number'.tr(),
                            controller: itemBloc.keyNetController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field_required'.tr();
                              }
                              return null; // إذا كانت القيمة صحيحة
                            },
                          ),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .25,
                          child: CustomTextField(
                            labelColor: const Color(0xff45596B),
                            labelText: 'check_number'.tr(),
                            hintText: 'check_number'.tr(),
                            controller: itemBloc.checkNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field_required'.tr();
                              }
                              return null; // إذا كانت القيمة صحيحة
                            },
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .25,
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
                              2.verticalSpace,
                              DatePickerWidget(
                                fillColor: const Color(0xff006296),
                                heightH: 45,
                                widthH:
                                MediaQuery.of(context).size.width * 0.25,
                                onDateSelected: (DateTime? selectedDate) {
                                  print(
                                    "Selected date:      ${DateFormat('yyyy/MM/dd', 'en_US').format(selectedDate!.toLocal())}",
                                  );
                                  itemBloc.CheckDueDate =
                                      itemBloc.CheckDueDate ??
                                          DateFormat(
                                            'yyyy/MM/dd',
                                            'en_US',
                                          ).format(DateTime.now());
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: MediaQuery.sizeOf(context).width * .25),
                      ],
                    ),
                    5.verticalSpace,
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'description'.tr(),
                        style: GoogleFonts.almarai(
                          color: const Color(0xff45596B),
                          fontSize: getFontSize(context, 16),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        controller: itemBloc.noteController,
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
                            vertical: 20,
                            horizontal: 16,
                          ),
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
                          width: MediaQuery.sizeOf(context).width * .2,
                          child: ConditionalBuilder(
                            condition:
                            BlocProvider.of<InvoiceCollectionCubit>(
                              context,
                            ).state
                            is! AddInvoiceCollectingLoading,
                            builder:
                                (context) => ElevatedButton(
                              onPressed: () {
                                if (widget.editCollection != null) {
                                  itemBloc.editInvoiceCollecting(
                                    branchId: itemBloc.branchId,
                                    codePw: itemBloc.codePw,
                                    currencyId: itemBloc.currencyId,
                                    currencyRate: itemBloc.currencyRate,
                                    voucherTypeId: itemBloc.voucherTypeId,
                                    context: context,
                                    voucherNumber:
                                    widget
                                        .editCollection["VoucherNumber"],
                                    invoiceID:
                                    widget.editCollection["InvoiceID"],
                                    invoiceNo:
                                    widget.editCollection["InvoiceNo"],
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
                                (widget.editCollection != null)
                                    ? Colors.orange
                                    : const Color(0xff1E40AF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: Text(
                                (widget.editCollection != null)
                                    ? 'edit'.tr()
                                    : 'sa_va'.tr(),
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
                          width: MediaQuery.sizeOf(context).width * .2,
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
      listener: (context, state) {},
    );
  }
}
