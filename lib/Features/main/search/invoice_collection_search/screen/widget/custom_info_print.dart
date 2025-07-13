import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../corec/sharde/font_responsive.dart';

class CustomInfoBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomInfoBox({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff000000).withOpacity(0.25),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.cairo(
                color: Color(0xff040943),
                fontWeight: FontWeight.bold,
//                fontSize: getFontSize(context, 18),
                fontSize: 20,

              ),
            ),

            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.cairo(
                color: Color(0xff040943),
                fontWeight: FontWeight.bold,
                // fontSize: getFontSize(context, 18),
                fontSize: 20,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
