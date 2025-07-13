import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Corec/local/chacheHelper.dart';
import 'package:theonepos/Corec/sharde/font_responsive.dart';
import 'package:theonepos/Features/main/newInvoice/manager/product_cubit.dart';
import 'layouts/mobile_invoice_summary_layout.dart';
import 'layouts/tablet_invoice_summary_layout.dart';

class InvoiceSummary extends StatelessWidget {
  final ProductViewCubit itemCubit;
  final dynamic editInvoice;

  const InvoiceSummary({super.key, required this.itemCubit, this.editInvoice});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    // Compute the invoice number
    String invoiceNumber =
        itemCubit.x == 1
            ? (CacheHelper.getData(key: "lastInvoiceID")?.toString() ?? "1")
            : itemCubit.x.toString();

    return Scaffold(
      backgroundColor: const Color(0xffEDF3FB),
      appBar: AppBar(
        backgroundColor: const Color(0xff2269A6),
        title: Row(
          children: [
            Text(
              'رقم الفاتوره $invoiceNumber',
              style: GoogleFonts.almarai(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: getFontSize(context, 14),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              'total'.tr(),
              style: GoogleFonts.almarai(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: getFontSize(context, 14),
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: LayoutBuilder(
          builder: (context, constrains) {
            if (constrains.maxWidth <= 550) {
              return MobileInvoiceSummaryLayout(
                itemCubit: itemCubit,
                editInvoice: editInvoice,
                numofInvoice: int.parse(invoiceNumber), // Convert to int
              );
            } else {
              return TabletInvoiceSummaryLayout(
                itemCubit: itemCubit,
                editInvoice: editInvoice,
                numofInvoice: int.parse(invoiceNumber), // Convert to int
              );
            }
          },
        ),
      ),
    );
  }
}
