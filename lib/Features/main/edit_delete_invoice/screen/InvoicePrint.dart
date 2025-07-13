import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Features/main/edit_delete_invoice/manager/invoice_print_cubit.dart';
import 'package:theonepos/Features/main/edit_delete_invoice/manager/invoice_print_state.dart';
import 'package:theonepos/Features/main/edit_delete_invoice/screen/printthermalorpdf.dart';
import '../../../../Corec/local/chacheHelper.dart';
import '../../../../Corec/utils/pdf/pdf_helper.dart';
import '../../../../corec/sharde/app_colors.dart';
import '../../../../corec/utils/widget/dotted_divider.dart';
import '../model/invoice_model.dart';

class InvoicePrint extends StatefulWidget {
  InvoiceModel dataInvoice;
  InvoicePrint({super.key, required this.dataInvoice});

  @override
  State<InvoicePrint> createState() => _InvoicePrintState();
}

class _InvoicePrintState extends State<InvoicePrint> {
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
  final paymentname=  CacheHelper.getData(key: "namePaymentMethod", );
    final paymentnameen=  CacheHelper.getData(key: "namePaymentEnMethod");
print(paymentnameen);
print(paymentname);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => InvoicePrintCubit()..getDataCompany(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PrintThermalOrPdf(
                isPrint: isPrint,
                onInitialized: (c) {
                  controller = c;
                },
                repaintKey: _globalKey,
                child: BlocBuilder<InvoicePrintCubit, InvoicePrintState>(
                  builder: (context, state) {
                    final currentLanguageCode = context.locale.languageCode;
                    final company =
                        context.read<InvoicePrintCubit>().dataCompanyList;
                    final invoice = widget.dataInvoice;
                    final screenWidth = MediaQuery.of(context).size.width;

                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: Row(
                              children: [
                                // IconButton(
                                //   icon: Icon(Icons.picture_as_pdf, color: AppColors.mainAppColor, size: 25),
                                //   onPressed: () async {
                                //     setState(() {
                                //       isPrint = false;
                                //     });
                                //     await PdfHelper.convertWidgetToPdf(_globalKey);
                                //   },
                                // ),
                                // InkWell(
                                //   onTap: () async {
                                //     setState(() {
                                //       isPrint = false;
                                //     });
                                //     // أي عملية أخرى
                                //   },
                                //   child: SvgPicture.asset('assets/icons/shara.svg', width: 40, height: 25),
                                // ),
                                IconButton(
                                  icon: Icon(
                                    Icons.print,
                                    color: AppColors.mainAppColor,
                                    size: 25,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      isPrint = true;
                                    });
                                    final address =
                                        await printerManager.selectDevice();
                                    if (address != null) {
                                      printerManager.controller = controller;
                                      await printerManager.printReceipt(
                                        address: address,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                   Container(

                     constraints: BoxConstraints(minHeight: 500),
                     child: Column(
                       children: [
                         SizedBox(height: 8),
                         Container(
                           width: double.infinity,
                           height: 1,
                           color: Colors.black12,
                         ),

                         // بيانات الشركة
                         if (company.isNotEmpty) ...[
                           Text(
                             currentLanguageCode == 'ar'
                                 ? company[0].arabicDBName ?? ''
                                 : company[0].englishDBName ?? '',
                             style: GoogleFonts.alexandria(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.black,
                             ),
                           ),
                           Text(
                             currentLanguageCode == 'ar'
                                 ? company[0].arabicAddress ?? ''
                                 : company[0].englishAddress ?? '',

                             style: GoogleFonts.alexandria(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.black,
                             ),
                           ),
                           Text(
                             company[0].phone?.toString() ?? '',
                             style: GoogleFonts.alexandria(fontSize: 8),
                           ),
                         ] else ...[
                           Text(
                             'No data available',
                             style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.grey,
                             ),
                           ),
                         ],

                         SizedBox(height: 10),
                         Container(
                           width: double.infinity,
                           height: 1,
                           color: Colors.black12,
                         ),

                         // اسم العميل والبيانات
                         Text(
                           (currentLanguageCode == 'ar')
                               ? invoice.patternArName ?? ''
                               : invoice.patternLatinName ?? '',
                           style: GoogleFonts.alexandria(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.black,
                           ),
                         ),

                         SizedBox(height: 10),
                         Row(
                           children: [
                             Text(
                               'invoice_number'.tr(),
                               style: GoogleFonts.alexandria(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             Spacer(),
                             Text(
                               invoice.invoiceNo.toString(),
                               style: GoogleFonts.alexandria(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ],
                         ),
                         Row(
                           children: [
                             Text(
                               'date'.tr(),
                               style: GoogleFonts.alexandria(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             Spacer(),
                             Text(
                               invoice.invoiceDate != null
                                   ? DateFormat('yyyy-MM-dd', 'en_US').format(
                                 DateTime.parse(
                                   invoice.invoiceDate.toString(),
                                 ),
                               )
                                   : 'غير متوفر',
                               style: GoogleFonts.alexandria(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ],
                         ),
                         Row(
                           children: [
                             Text(
                               'customer'.tr(),
                               style: GoogleFonts.alexandria(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             Spacer(),
                             Text(
                               (currentLanguageCode == 'ar')
                                   ? invoice.customerName ?? ''
                                   : invoice.customerEnName ?? '',
                               style: GoogleFonts.alexandria(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ],
                         ),

                         SizedBox(height: 10),
                         Container(
                           width: double.infinity,
                           height: 1,
                           color: Colors.black12,
                         ),

                         // العناوين
                         Row(
                           children: [
                             Expanded(
                               flex: 2,
                               child: Text(
                                 'item'.tr(),
                                 style: GoogleFonts.alexandria(
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                             Expanded(
                               flex: 1,
                               child: Text(
                                 'quantity'.tr(),
                                 style: GoogleFonts.alexandria(
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                             Expanded(
                               flex: 1,
                               child: Text(
                                 'unit_price'.tr(),
                                 style: GoogleFonts.alexandria(
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                             Expanded(
                               flex: 1,
                               child: Text(
                                 'subtotal'.tr(),
                                 style:
                                 GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                               ),
                             ),
                           ],
                         ),

                         Container(
                           width: double.infinity,
                           height: 1,
                           color: Colors.black12,
                         ),

                         // عناصر الفاتورة
                         ...invoice.salesInvoiceItems.map((item) {
                           final subtotal =
                               (item.price ?? 0) * (item.quantity ?? 0);
                           return Column(
                             children: [
                               SizedBox(height: 5),
                               Row(
                                 children: [
                                   Expanded(
                                     flex: 2,
                                     child: Text(
                                       (currentLanguageCode == 'ar')
                                           ? item.productArName ?? ''
                                           : item.productEnName ?? '',
                                       style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                     ),
                                   ),
                                   Expanded(
                                     flex: 1,
                                     child: Text(
                                       '${item.quantity ?? ''}',
                                       style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                     ),
                                   ),
                                   Expanded(
                                     flex: 1,
                                     child: Text(
                                       '${item.price ?? ''}',
                                       style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                     ),
                                   ),
                                   Expanded(
                                     flex: 1,
                                     child: Text(
                                       subtotal.toStringAsFixed(3),
                                       style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 10),
                             ],
                           );
                         }).toList(),

                         SizedBox(height: 10),
                         Container(
                           width: double.infinity,
                           height: 1,
                           color: Colors.black12,
                         ),

                         // طرق الدفع
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               'payment_method'.tr(),
                               style: GoogleFonts.alexandria(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.black,
                               ),
                             ),
                             const SizedBox(width: 8),
                             Expanded(
                               child: Wrap(
                                 spacing: 8,
                                 runSpacing: 4,
                                 children: invoice.salesInvoicePayWay.map((payWay) {
                                   return Row(
                                     mainAxisSize: MainAxisSize.min,
                                     children: [
                                       Text(
                                         (currentLanguageCode == 'ar')
                                             ? (payWay.payWayName ?? paymentname)
                                             : (payWay.payWayEnName ?? paymentnameen),
                                         style: GoogleFonts.alexandria(
                                           fontSize: 20,
                                           fontWeight: FontWeight.bold,
                                           color: Colors.black,
                                         ),
                                       ),
                                       const SizedBox(width: 4),
                                       Text(
                                         payWay.payingValue?.toString() ?? '',
                                         style: GoogleFonts.alexandria(
                                           fontSize: 20,
                                           fontWeight: FontWeight.bold,
                                           color: Colors.black,
                                         ),
                                       ),
                                     ],
                                   );
                                 }).toList(),
                               ),
                             ),
                           ],
                         ),

                         SizedBox(height: 10),
                         Row(
                           children: [
                             Text(
                               'total'.tr(),
                               style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                             ),
                             Spacer(),
                             Text(
                               invoice.totalValue.toString(),
                               style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                             ),
                           ],
                         ),
                         Row(
                           children: [
                             Text(
                               'addition'.tr(),
                               style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                             ),
                             Spacer(),
                             Text(
                               invoice.totalAddition.toString(),
                               style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                             ),
                           ],
                         ),
                         Row(
                           children: [
                             Text(
                               'discount'.tr(),
                               style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                             ),
                             Spacer(),
                             Text(
                               invoice.totalDiscount.toString(),
                               style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                             ),
                           ],
                         ),

                         SizedBox(height: 10),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               'total_invoice'.tr(),
                               style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                             ),
                             SizedBox(width: 15),
                             Text(
                               invoice.finalValue.toString(),
                               style: GoogleFonts.alexandria(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                             ),
                           ],
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 8),
                           child: CustomPaint(
                             painter: DottedDividerPainter(),
                             child: Container(height: 1),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 8),
                           child: CustomPaint(
                             painter: DottedDividerPainter(),
                             child: Container(height: 1),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 8),
                           child: CustomPaint(
                             painter: DottedDividerPainter(),
                             child: Container(height: 1),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 8),
                           child: CustomPaint(
                             painter: DottedDividerPainter(),
                             child: Container(height: 1),
                           ),
                         ),
                         SizedBox(height: 200),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 8),
                           child: CustomPaint(
                             painter: DottedDividerPainter(),
                             child: Container(height: 1),
                           ),
                         ),
                       ],
                     ),
                   )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
