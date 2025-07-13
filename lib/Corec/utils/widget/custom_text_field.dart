import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../sharde/font_responsive.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Color borderColor;
  final Color textColor;
  final Color fillColor;
  final String labelText;
  final Color labelColor;
  final Color enableColor;
  final Color focusedColor;
  final Color hintColor;

  final TextEditingController? controller;
  final EdgeInsetsGeometry contentPadding;
  final bool readOnly;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  const CustomTextField({
    required this.labelText,
    super.key,
    required this.hintText,
    this.borderColor = Colors.white,
    this.fillColor = const Color(0xff006296),
    this.labelColor = const Color(0xffC6C6C6),
    this.focusedColor = const Color(0xffffffff),
    this.textColor = const Color(0xffC6C6C6),
    this.enableColor = const Color(0xff006296),
    this.hintColor = const Color(0xffC6C6C6),
    this.controller,
    this.readOnly = false,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 16,
    ),
    this.validator, // تمرير validator
    this.inputFormatters,
    this.onChanged, // تمرير inputFormatters
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.almarai(
            color: labelColor,
            fontSize: getFontSize(context, 16),
            fontWeight: FontWeight.w500,
          ),
        ),
        2.verticalSpace,
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.almarai(
              color: hintColor,
              fontSize: getFontSize(context, 13),
              fontWeight: FontWeight.normal,
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
            fontSize: getFontSize(context, 16),
            fontWeight: FontWeight.w500,
          ),
          validator: validator, // استخدام validator هنا
          inputFormatters: inputFormatters, // استخدام inputFormatters هنا
        ),
      ],
    );
  }
}
