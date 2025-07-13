import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/corec/sharde/font_responsive.dart';

class ComponentInfoDisplay extends StatelessWidget {
  final String label;
  final String value;
  final dynamic widthW;

  const ComponentInfoDisplay({
    super.key,
    required this.label,
    required this.value,
    this.widthW,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.almarai(
            color: Colors.white,
            fontSize: getFontSize(context, 14),
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis, // Prevents overflow with ellipsis
        ),
        Container(
          width: widthW,
          decoration: BoxDecoration(
            color: const Color(0xffE7EBEF),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          child: Text(
            value,
            style: GoogleFonts.almarai(
              color: const Color(0xff090A0B),
              fontSize: getFontSize(context, 14),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis, // Prevents overflow with ellipsis
          ),
        ),
      ],
    );
  }
}
