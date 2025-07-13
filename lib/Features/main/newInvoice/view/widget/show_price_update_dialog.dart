import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:theonepos/corec/sharde/font_responsive.dart";
import "package:theonepos/Features/main/newInvoice/manager/product_cubit.dart";

Future<void> showPriceUpdateDialog({
  required BuildContext context,
  required double currentPrice,
  required ProductViewCubit cubit,
  required int index,
}) async {
  TextEditingController priceController = TextEditingController(
    text: currentPrice.toString(),
  );
  String? noteText; // تخزين الملاحظة هنا

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            'edit_item_price'.tr(),
            style: GoogleFonts.alexandria(
              fontSize: getFontSize(context, 14),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "edit_item_price".tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Color(0xff2269A6),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 25,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: const Color(0xff2269A6)),
                    ),
                    child: Center(
                      child: Text(
                        'cancel'.tr(),
                        style: TextStyle(
                          color: const Color(0xff2269A6),
                          fontSize: getFontSize(context, 12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (priceController.text.isNotEmpty) {
                      double? newPrice = double.tryParse(priceController.text);
                      if (newPrice != null) {
                        cubit.updatePrice(index: index, newPrice: newPrice);
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xff2269A6),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Text(
                        'edit'.tr(),
                        style: TextStyle(
                          fontSize: getFontSize(context, 12),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<String?> showNoteDialog({
  required BuildContext context,
  required ProductViewCubit cubit,
  required int index,
  required String note,
}) async {
  TextEditingController noteController = TextEditingController(text: note);

  return await showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            'add_note'.tr(),
            style: GoogleFonts.alexandria(
              fontSize: getFontSize(context, 14),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        content: TextField(
          controller: noteController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'add_note'.tr(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xff2269A6), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 25,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, null); // إغلاق بدون حفظ
            },
            child: Text(
              'cancel'.tr(),
              style: TextStyle(
                color: const Color(0xff2269A6),
                fontSize: getFontSize(context, 12),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (noteController.text.isNotEmpty) {
                cubit.updatenotes(index: index, notes: noteController.text);
                Navigator.pop(context, noteController.text); // ترجع القيمة
              }
            },
            child: Text(
              'save'.tr(),
              style: TextStyle(
                color: const Color(0xff2269A6),
                fontSize: getFontSize(context, 12),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
