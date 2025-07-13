import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/corec/sharde/font_responsive.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function function;
  final Color backgroundColor;
  final Color textColor;
  final bool showIcon;

  const DefaultButton({
    super.key,
    required this.text,
    required this.function,
    this.backgroundColor = const Color(0xff293798),
    this.textColor = Colors.white,
    this.showIcon = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      width: double.infinity,
      height: 45.h,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon) Image.asset('assets/images/loadSetting.png'),
            const SizedBox(width: 5),

            Text(
              text,
              style: GoogleFonts.almarai(
                fontSize: getFontSize(context, 16),
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
