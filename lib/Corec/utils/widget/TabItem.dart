import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:theonepos/corec/sharde/font_responsive.dart';

class TabItem extends StatelessWidget {
  final String? title;
  final Function() onTap;
  final bool isSelected;
  final bool isMainGroup;

  const TabItem({
    super.key,
    this.title,
    required this.onTap,
    required this.isSelected,
    required this.isMainGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.r),
      child: Material(
        borderRadius:
            isMainGroup
                ? BorderRadius.circular(6.r)
                : BorderRadius.circular(25.r),
        color:
            isSelected
                ? const Color(0xff2269A6)
                : (isMainGroup
                    ? Colors.white
                    : const Color(0xffF8F8F8)), // لون مختلف
        child: InkWell(
          borderRadius: BorderRadius.circular(100.r),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    isSelected
                        ? Colors.white
                        : (isMainGroup
                            ? const Color(0xff1261A5)
                            : const Color(0xffCCCCCC)), // حدود مختلفة
                width: 1.0,
              ),
              borderRadius:
                  isMainGroup
                      ? BorderRadius.circular(6.r)
                      : BorderRadius.circular(25.r),
            ),
            alignment: Alignment.center,
            padding: REdgeInsets.symmetric(horizontal: 19),
            child: Center(
              child: Text(
                '$title',
                style: GoogleFonts.tajawal(
                  fontSize: getFontSize(
                    context,
                    isMainGroup ? 14 : 12,
                  ), // حجم خط مختلف
                  fontWeight:
                      isMainGroup
                          ? FontWeight.w700
                          : FontWeight.w500, // وزن خط مختلف
                  color: isSelected ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
