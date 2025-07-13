import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../corec/sharde/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hintText;
  final Widget? prefix;
  final Widget? subfix;
  final dynamic obscureText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged; // إضافة onChanged
  final FocusNode? focusNode; // إضافة focusNode

  const CustomTextFormField({
    super.key,
    this.controller,
    this.textInputType = TextInputType.text,
    this.hintText,
    this.prefix,
    this.validator,
    this.subfix,
    this.obscureText,
    this.onChanged,
    this.focusNode, // تمرير focusNode
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode, // تمرير focusNode إلى TextFormField
        decoration: InputDecoration(
          suffixIcon: widget.subfix,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide.none,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: const Color(0xff9A9A9A),
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'Madani',
          ),
          fillColor: const Color(0xffE7EAEF),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mainAppColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mainAppColor),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 6.0,
          ),
          prefixIcon: widget.prefix,
        ),
        keyboardType: widget.textInputType,
        validator: widget.validator,
        obscureText: widget.obscureText ?? false,
        onChanged: widget.onChanged,
      ),
    );
  }
}
