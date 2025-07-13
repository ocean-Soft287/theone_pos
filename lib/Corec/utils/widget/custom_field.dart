import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../corec/sharde/font_responsive.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final Color borderColor;
  final Color fillColor;
  final Color enableColor;
  final Color focusedColor;
  final Color textColor;
  final TextEditingController? controller;
  final EdgeInsetsGeometry contentPadding;
  final bool readOnly;
  final ValueChanged<String>? onChanged;

  const CustomField({
    super.key,
    required this.hintText,
    this.borderColor = Colors.white,
    this.fillColor = const Color(0xff006296),
    this.focusedColor = const Color(0xffffffff),
    this.enableColor = const Color(0xff006296),
    this.textColor = const Color(0xffC6C6C6),
    this.controller,
    this.readOnly = false,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 16,
    ),
    this.onChanged, // إضافة onChanged إلى المعلمات
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      onChanged: onChanged, // تمرير onChanged إلى TextFormField

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.almarai(
          color: const Color(0xffC6C6C6),
          fontSize: getFontSize(context, 16),
          fontWeight: FontWeight.w700,
        ),
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.orange, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: focusedColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: enableColor, width: 1),
        ),
        fillColor: fillColor,
        filled: true,
      ),
      style: GoogleFonts.almarai(
        color: textColor,
        fontSize: getFontSize(context, 14),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
