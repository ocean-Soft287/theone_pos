import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Features/main/customer_statement/manager/customer_statement_cubit.dart';
import 'package:theonepos/Features/main/customer_statement/manager/customer_statement_state.dart';
import 'package:theonepos/Features/main/customer_statement/screen/search_customer_statement_screen.dart';
import '../../../../corec/sharde/consts.dart';
import '../../../../corec/sharde/font_responsive.dart';
import '../../../../corec/utils/widget/app_setup_dialog.dart';
import '../../../../corec/utils/widget/custom_text_field.dart';
import '../../../../corec/utils/widget/data_picker.dart';

class CustomerStatementScreen extends StatelessWidget {
  CustomerStatementScreen({super.key});
  Map<String, dynamic>? result;
  final TextEditingController controllerName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD9F1FD),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff3942A6),
        centerTitle: true,
        title: Text(
          'account_statement'.tr(),
          style: GoogleFonts.almarai(
            color: Colors.white,
            fontSize: getFontSize(context, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:
          (userId == null)
              ? const AppSetupDialog()
              : BlocProvider(
                create: (context) => CustomerStatementCubit(),
                child: BlocConsumer<
                  CustomerStatementCubit,
                  CustomerStatementState
                >(
                  listener: (context, state) {},
                  builder: (context, state) {
                    CustomerStatementCubit customerStatementCubit =
                        BlocProvider.of(context);
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LayoutBuilder(
                            builder: (context, constrains) {
                              if (constrains.maxWidth <= 600) {
                                return Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  color: const Color(0xff3942A6),
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      8.verticalSpace,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .5,
                                            child: CustomTextField(
                                              controller: controllerName,
                                              labelText: 'client_name'.tr(),
                                              fillColor: const Color(
                                                0xff3942A6,
                                              ),
                                              hintText:
                                                  '${result?["AcountName"] ?? customer?["AcountName"] ?? 'ابحث'}',
                                              readOnly: true,
                                              enableColor: Colors.white,
                                              focusedColor:
                                                  Colors.lightGreenAccent,
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .3,
                                            child: ElevatedButton.icon(
                                              onPressed: () async {
                                                result = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            SearchCustomerStatementScreen(),
                                                  ),
                                                );
                                                controllerName.text =
                                                    result?["ArabicName"];
                                              },
                                              icon: Icon(
                                                Icons.search,
                                                size: getFontSize(context, 24),
                                                color: Colors.white,
                                              ),
                                              label: Text(
                                                'search'.tr(),
                                                style: GoogleFonts.almarai(
                                                  fontSize: getFontSize(
                                                    context,
                                                    14,
                                                  ),
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xff186FDC,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 10,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      10.verticalSpace,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'from'.tr(),
                                                    style: GoogleFonts.almarai(
                                                      color: Colors.white,
                                                      fontSize: getFontSize(
                                                        context,
                                                        16,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  10.horizontalSpace,
                                                  DatePickerWidget(
                                                    onDateSelected: (
                                                      DateTime? selectedDate,
                                                    ) {
                                                      print(
                                                        "Selected date: ${DateFormat('yyyy/MM/dd', 'en_US').format(selectedDate!.toLocal())}",
                                                      );
                                                      customerStatementCubit
                                                              .fromDate =
                                                          DateFormat(
                                                            'yyyy/MM/dd',
                                                            'en_US',
                                                          ).format(
                                                            selectedDate
                                                                .toLocal(),
                                                          ) ??
                                                          DateFormat(
                                                            'yyyy/MM/dd',
                                                            'en_US',
                                                          ).format(
                                                            DateTime.now(),
                                                          );
                                                    },
                                                    fillColor: const Color(
                                                      0xffFFFFFF,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.verticalSpace,
                                              Row(
                                                children: [
                                                  Text(
                                                    'to  '.tr(),
                                                    style: GoogleFonts.almarai(
                                                      color: Colors.white,
                                                      fontSize: getFontSize(
                                                        context,
                                                        16,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  10.horizontalSpace,
                                                  DatePickerWidget(
                                                    onDateSelected: (
                                                      DateTime? selectedDate,
                                                    ) {
                                                      print(
                                                        "Selected date: ${DateFormat('yyyy/MM/dd', 'en_US').format(selectedDate!.toLocal())}",
                                                      );
                                                      customerStatementCubit
                                                          .toDate = DateFormat(
                                                            'yyyy/MM/dd',
                                                            'en_US',
                                                          ).format(
                                                            selectedDate
                                                                .toLocal(),
                                                          ) ??
                                                          DateFormat(
                                                            'yyyy/MM/dd',
                                                            'en_US',
                                                          ).format(
                                                            DateTime.now(),
                                                          );
                                                    },
                                                    fillColor: const Color(
                                                      0xffFFFFFF,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  if ((result?["CustomerPhone"] ==
                                                      null)) {
                                                    Fluttertoast.showToast(
                                                      msg: "ابحث عن الاسم ",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0,
                                                    );
                                                  } else {
                                                    customerStatementCubit
                                                        .getCustomerStatement(
                                                          customerPhone:
                                                              result?["CustomerPhone"],
                                                        );
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.check,
                                                  size: getFontSize(
                                                    context,
                                                    18,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                label: Text(
                                                  'execute'.tr(),
                                                  style: GoogleFonts.almarai(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.orange,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 8,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              10.verticalSpace,
                                              ElevatedButton.icon(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.visibility,
                                                  size: getFontSize(
                                                    context,
                                                    16,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                label: Text(
                                                  'preview'.tr(),
                                                  style: GoogleFonts.almarai(
                                                    fontSize: getFontSize(
                                                      context,
                                                      16,
                                                    ),
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(
                                                    0xff42A5F5,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 8,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      30.verticalSpace,
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  color: const Color(0xff3942A6),
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      8.verticalSpace,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .5,
                                            child: CustomTextField(
                                              readOnly: true,
                                              controller: controllerName,
                                              labelText: 'client_name'.tr(),
                                              fillColor: const Color(
                                                0xff3942A6,
                                              ),
                                              hintText:
                                                  '${result?["ArabicName"] ?? 'ابحث'}',
                                              enableColor: Colors.white,
                                              focusedColor:
                                                  Colors.lightGreenAccent,
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .3,
                                            child: ElevatedButton.icon(
                                              onPressed: () async {
                                                result = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            SearchCustomerStatementScreen(),
                                                  ),
                                                );
                                                controllerName.text =
                                                    result?["ArabicName"];
                                              },
                                              icon: Icon(
                                                Icons.search,
                                                size: getFontSize(context, 24),
                                                color: Colors.white,
                                              ),
                                              label: Text(
                                                'search'.tr(),
                                                style: GoogleFonts.almarai(
                                                  fontSize: getFontSize(
                                                    context,
                                                    14,
                                                  ),
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xff186FDC,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 10,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      10.verticalSpace,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'from'.tr(),
                                                    style: GoogleFonts.almarai(
                                                      color: Colors.white,
                                                      fontSize: getFontSize(
                                                        context,
                                                        14,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  10.horizontalSpace,
                                                  DatePickerWidget(
                                                    widthH: 150,
                                                    onDateSelected: (
                                                      DateTime? selectedDate,
                                                    ) {
                                                      print(
                                                        "Selected date: ${DateFormat('yyyy/MM/dd', 'en_US').format(selectedDate!.toLocal())}",
                                                      );
                                                      customerStatementCubit
                                                              .fromDate =
                                                          DateFormat(
                                                            'yyyy/MM/dd',
                                                            'en_US',
                                                          ).format(
                                                            selectedDate
                                                                .toLocal(),
                                                          ) ??
                                                          DateFormat(
                                                            'yyyy/MM/dd',
                                                            'en_US',
                                                          ).format(
                                                            DateTime.now(),
                                                          );
                                                    },
                                                    heightH: 50,
                                                    fillColor: const Color(
                                                      0xffFFFFFF,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.verticalSpace,
                                              Row(
                                                children: [
                                                  Text(
                                                    'to  '.tr(),
                                                    style: GoogleFonts.almarai(
                                                      color: Colors.white,
                                                      fontSize: getFontSize(
                                                        context,
                                                        14,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  10.horizontalSpace,
                                                  DatePickerWidget(
                                                    widthH: 150,
                                                    heightH: 50,
                                                    onDateSelected: (
                                                      DateTime? selectedDate,
                                                    ) {
                                                      print(
                                                        "Selected date: ${DateFormat('yyyy/MM/dd', 'en_US').format(selectedDate!.toLocal())}",
                                                      );
                                                      customerStatementCubit
                                                          .toDate = DateFormat(
                                                            'yyyy/MM/dd',
                                                            'en_US',
                                                          ).format(
                                                            selectedDate
                                                                .toLocal(),
                                                          ) ??
                                                          DateFormat(
                                                            'yyyy/MM/dd',
                                                            'en_US',
                                                          ).format(
                                                            DateTime.now(),
                                                          );
                                                    },
                                                    fillColor: const Color(
                                                      0xffFFFFFF,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(
                                                      context,
                                                    ).width *
                                                    .25,
                                                child: ElevatedButton.icon(
                                                  onPressed: () {
                                                    if ((result?["CustomerPhone"] ==
                                                        null)) {
                                                      Fluttertoast.showToast(
                                                        msg: "ابحث عن الاسم ",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0,
                                                      );
                                                    } else {
                                                      customerStatementCubit
                                                          .getCustomerStatement(
                                                            customerPhone:
                                                                result?["CustomerPhone"],
                                                          );
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.check,
                                                    size: getFontSize(
                                                      context,
                                                      16,
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  label: Text(
                                                    'execute'.tr(),
                                                    style: GoogleFonts.almarai(
                                                      fontSize: getFontSize(
                                                        context,
                                                        16,
                                                      ),
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.orange,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 12,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              10.verticalSpace,
                                              SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(
                                                      context,
                                                    ).width *
                                                    .25,
                                                child: ElevatedButton.icon(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons
                                                        .visibility, // أيقونة "معاينة"
                                                    size: getFontSize(
                                                      context,
                                                      16,
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  label: Text(
                                                    'preview'.tr(),
                                                    style: GoogleFonts.almarai(
                                                      fontSize: getFontSize(
                                                        context,
                                                        16,
                                                      ),
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xff42A5F5),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 12,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      30.verticalSpace,
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                          Container(
                            color: const Color(0xffD9F1FD),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize:
                                    MainAxisSize
                                        .min, // Shrink-wrap the children vertically
                                children: [
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
                                          child: Text(
                                            'document_number'.tr(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.almarai(
                                              color: Colors.white,
                                              fontSize: getFontSize(
                                                context,
                                                14,
                                              ),
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'balance'.tr(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.almarai(
                                              color: Colors.white,
                                              fontSize: getFontSize(
                                                context,
                                                14,
                                              ),
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'date'.tr(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.almarai(
                                              color: Colors.white,
                                              fontSize: getFontSize(
                                                context,
                                                14,
                                              ),
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'debit'.tr(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.almarai(
                                              color: Colors.white,
                                              fontSize: getFontSize(
                                                context,
                                                14,
                                              ),
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'credit'.tr(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.almarai(
                                              color: Colors.white,
                                              fontSize: getFontSize(
                                                context,
                                                14,
                                              ),
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          customerStatementCubit
                                              .customerStatementList
                                              .length,
                                      itemBuilder:
                                          (context, index) => Column(
                                            children: [
                                              SizedBox(
                                                height: 50.h,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '${customerStatementCubit.customerStatementList[index]['InvoiceNumber']}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.almarai(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  getFontSize(
                                                                    context,
                                                                    14,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '${customerStatementCubit.customerStatementList[index]['Balance']}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.almarai(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  getFontSize(
                                                                    context,
                                                                    14,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        DateFormat(
                                                          'dd/MM/yyyy',
                                                          'en',
                                                        ).format(
                                                          DateTime.parse(
                                                            customerStatementCubit
                                                                .customerStatementList[index]['Date'],
                                                          ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.almarai(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  getFontSize(
                                                                    context,
                                                                    14,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '${customerStatementCubit.customerStatementList[index]['Credit']}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.almarai(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  getFontSize(
                                                                    context,
                                                                    14,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '${customerStatementCubit.customerStatementList[index]['Debit']}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.almarai(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  getFontSize(
                                                                    context,
                                                                    14,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Divider(thickness: 1),
                                            ],
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
