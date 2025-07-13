import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Features/main/edit_delete_invoice/screen/printthermalorpdf.dart';
import 'package:theonepos/Features/main/search/invoice_collection_search/screen/widget/custom_info_print.dart';
import '../../../../../Corec/utils/pdf/pdf_helper.dart';
import '../../../../../corec/sharde/app_colors.dart';
import '../model/invoice_collection_model.dart';

class CollectionVoucherPrinting extends StatefulWidget {
  final VoucherModel voucherModel;
  CollectionVoucherPrinting({super.key, required this.voucherModel});

  @override
  State<CollectionVoucherPrinting> createState() => _CollectionVoucherPrintingState();
}

class _CollectionVoucherPrintingState extends State<CollectionVoucherPrinting> {
  final GlobalKey _globalKey = GlobalKey();

  ReceiptController? controller;

  bool isPrint = true;

  late PrinterManager printerManager;

  @override
  void initState() {
    super.initState();
    printerManager = PrinterManager(context);
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    String currentLanguageCode = currentLocale.languageCode;
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        leading: Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xffFFFFFF), width: 1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Row(
            children: [
              // // زر PDF
              // IconButton(
              //   icon: Icon(Icons.picture_as_pdf, color: AppColors.mainAppColor),
              //   onPressed: () async {
              //     await PdfHelper.convertWidgetToPdf(_globalKey);
              //   },
              // ),
              // // زر مشاركة واتساب
              // IconButton(
              //   icon: SvgPicture.asset('assets/icons/shara.svg', width: 25, height: 25),
              //   onPressed: () async {
              //     await PdfHelper.convertWidgetToPdfAndSendToWhatsapp(_globalKey);
              //   },
              // ),
              IconButton(
                icon: Icon(Icons.print, color: AppColors.mainAppColor, size: 25),
                onPressed: () async {
                  setState(() {
                    isPrint = true;
                  });
                  final address = await printerManager.selectDevice();
                  if (address != null) {
                    printerManager.controller = controller;
                    await printerManager.printReceipt(address: address);
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: PrintThermalOrPdf(

          key: _globalKey,
          isPrint: isPrint,
          onInitialized: (c) {
            controller = c;
          },
          repaintKey: _globalKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: MultipleRoundedPointsClipper(
                    Sides.bottom,
                    heightOfPoint: 30,
                  ),

                  child: Card(
                    color: Colors.white,
                    elevation: 20,
                    shadowColor: Colors.black,
                    child: Container(
                      // margin: const EdgeInsets.only(bottom:  20),
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        boxShadow: [],
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          20.verticalSpace,
                          Text(
                            (currentLanguageCode == 'ar')
                                ? widget.voucherModel.voucherName ?? ''
                                : widget.voucherModel.voucherEnglishName ?? '',
                            style:   GoogleFonts.cairo(
                              color: Color(0xff040943),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          //  Text('${'payment_has_been_completed_successfully'.tr()} ${voucherModel.voucherNumber??0}',style:GoogleFonts.amiri(
                          //       color: Color(0xff040943),
                          //       fontWeight: FontWeight.w400,
                          //       fontSize: getFontSize(context, 14)
                          //   ) ,),
                          SizedBox(height: 10),
                          Text(
                            '${'receipt_voucher_number'.tr()} ${widget.voucherModel.voucherNumber ?? 0}',
                            style:   GoogleFonts.cairo(
                              color: Color(0xff040943),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Divider(
                              color: Color(0xff040943),
                              thickness: 0.1,
                              endIndent: 25,
                              indent: 25,
                            ),
                          ),
                          Text(
                            'value'.tr(),
                            style: GoogleFonts.cairo(
                              color: Color(0xff040943),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.voucherModel.voucherValue ?? 0}',
                                style: GoogleFonts.cairo(
                                  color: Color(0xff040943),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                (currentLanguageCode == 'ar')
                                    ? widget.voucherModel.currencyName ?? ''
                                    : widget.voucherModel.currencyLatinName ?? '',

                                style: GoogleFonts.cairo(
                                  color: Color(0xff040943),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          Row(
                            children: [
                              CustomInfoBox(
                                title: "date".tr(),
                                subtitle: DateFormat(
                                  'yyyy-MM-dd ',
                                  'en',
                                ).format(
                                  DateTime.parse(
                                    widget.voucherModel.creationDateTime as String,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              CustomInfoBox(
                                title: "time".tr(),
                                subtitle: DateFormat('hh:mm a', 'en').format(
                                  DateTime.parse(
                                    '2000-01-01 ${widget.voucherModel.creationTime}',
                                  ),

                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              CustomInfoBox(
                                title: "collection_method".tr(),
                                subtitle:
                                    (currentLanguageCode == 'ar')
                                        ? widget.voucherModel.namePW ?? ''
                                        : widget.voucherModel.eNamePW ?? '',
                              ),
                              const SizedBox(width: 8),
                              CustomInfoBox(
                                title: "credit_account".tr(),
                                subtitle:
                                    (currentLanguageCode == 'ar')
                                        ? widget.voucherModel
                                                .voucherAccounts[0]
                                                .acName ??
                                            ''
                                        : widget.voucherModel
                                                .voucherAccounts[0]
                                                .acLatinName ??
                                            '',
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Row(
                          //   children: [
                          //     CustomInfoBox(
                          //         title: "currency".tr(),
                          //         subtitle:(currentLanguageCode=='ar') ?voucherModel.currencyName??'':
                          //         voucherModel.currencyLatinName??''
                          //     ),
                          //     const SizedBox(width: 8),
                          //     CustomInfoBox(
                          //         title:"exchange_rate".tr(),
                          //         subtitle:
                          //         voucherModel.currencyRate.toString()??''
                          //     ),
                          //     const SizedBox(width: 8),
                          //     CustomInfoBox(
                          //       title: "approval_number".tr(),
                          //       subtitle: '${voucherModel.agreementNo??''}',
                          //     ),
                          //   ],
                          // ),

                          // const SizedBox(
                          //   height:12 ,
                          // ),

                          // Row(
                          //   children: [
                          //    CustomInfoBox(
                          //       title: "cost_center".tr(),
                          //       subtitle: (currentLanguageCode=='ar') ?
                          //       voucherModel.voucherAccounts[0].costCenterName??''
                          //           :
                          //       voucherModel.voucherAccounts[0].costCenterLatinName??''
                          //     ),
                          //     const SizedBox(width: 8),
                          //     CustomInfoBox(
                          //       title:"account_name".tr(),
                          //       subtitle:
                          //       (currentLanguageCode=='ar') ?
                          //       voucherModel.cashAcName??''
                          //           :
                          //       voucherModel.cashAcLatinName??''
                          //       ,
                          //     ),
                          //   ],
                          // ),const SizedBox(
                          //   height:12 ,
                          // ),
                          Row(
                            children: [
                              CustomInfoBox(
                                title: "company_branch".tr(),
                                subtitle:
                                    widget.voucherModel.branchId.toString() ?? '',
                              ),
                              const SizedBox(width: 8), // مسافة بين الصندوقين
                              CustomInfoBox(
                                title: "collection_representative".tr(),
                                subtitle: widget.voucherModel.employeeName ?? '',
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              //  CustomInfoBox(
                              //     title: "phone".tr(),
                              //     subtitle: voucherModel.customerPhone??''
                              //   ),

                              //   const SizedBox(width: 8),
                              CustomInfoBox(
                                title: "keynet_number".tr(),
                                subtitle:
                                    "${widget.voucherModel.voucherAccounts[0].keyNet ?? ''}",
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              //  CustomInfoBox(
                              //   title: "phone_2".tr(),
                              //   subtitle:"",
                              // ),
                              // const SizedBox(width: 8), // مسافة بين الصندوقين
                              CustomInfoBox(
                                title: "account_name".tr(),
                                subtitle:
                                    (currentLanguageCode == 'ar')
                                        ? widget.voucherModel.cashAcName ?? ''
                                        : widget.voucherModel.cashAcLatinName ?? '',
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              CustomInfoBox(
                                title: "check_number".tr(),
                                subtitle: widget.voucherModel.checkNumber ?? '',
                              ),
                              const SizedBox(width: 8),
                              CustomInfoBox(
                                title: "due_date".tr(),
                                subtitle: DateFormat(
                                  'yyyy-MM-dd ',
                                  'en',
                                ).format(
                                  DateTime.parse(
                                    widget.voucherModel.checkDueDate ?? '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                               CustomInfoBox(
                                title: "الرصيد المتبقي".tr(),
                                subtitle:"", //"${voucherModel.voucherNumber??''}"
                              ),
                              const SizedBox(width: 8),
                              CustomInfoBox(
                                title: "الرصيد السابق".tr(),
                                subtitle:"",// voucherModel.cashAcCode ?? '',
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              CustomInfoBox(
                                title: "description".tr(),
                                subtitle: widget.voucherModel.notes ?? '',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'توقيع المحصل :',
                                style: GoogleFonts.amiri(
                                  color: Color(0xff040943),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CustomPaint(
                              child: Container(height: 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CustomPaint(
                              child: Container(height: 1),
                            ),
                          ),      Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CustomPaint(
                              child: Container(height: 1),
                            ),
                          ),      Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CustomPaint(
                              child: Container(height: 1),
                            ),

                          ),
                          Container(
                            height: 300,
                            color: Color(0xffFFFFFF),

                          ),
                          const SizedBox(height: 15),
                          const SizedBox(height: 15),

                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -15,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Material(
                      elevation: 10,
                      shape: const CircleBorder(),
                      shadowColor: Colors.black26,
                      color: Colors.white,

                      child: Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff040943),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



