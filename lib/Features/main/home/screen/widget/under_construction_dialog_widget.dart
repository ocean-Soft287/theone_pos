import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../corec/sharde/app_colors.dart';
import '../../../../../corec/sharde/font_responsive.dart';

class UnderConstructionDialog extends StatelessWidget {
  const UnderConstructionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        '"under_construction'.tr(),
        style: GoogleFonts.alexandria(
          fontSize: getFontSize(context, 16),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.build_rounded, color: AppColors.mainAppColor, size: 50),
          const SizedBox(height: 10),
          Text(
            'page_under_development'.tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.alexandria(
              fontSize: getFontSize(context, 14),
              color: Colors.black,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.mainAppColor, width: 2),
            ),
            child: Text(
              'ok'.tr(),
              style: GoogleFonts.alexandria(
                fontSize: getFontSize(context, 16),
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void showUnderConstructionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const UnderConstructionDialog(),
  );
}
