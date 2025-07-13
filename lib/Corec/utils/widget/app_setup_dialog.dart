import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../Features/main/setting/register/register_screen.dart';
import '../../sharde/font_responsive.dart';

class AppSetupDialog extends StatelessWidget {
  const AppSetupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFF5F5F5),
      title: Text(
        'please_configure_settings'.tr(),
        style: GoogleFonts.almarai(
          color: Colors.black,
          fontSize: getFontSize(context, 18),
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100,
            child: Lottie.asset('assets/images/lotter.json', fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Text(
            'please_configure_settings_to_continue'.tr(),
            style: GoogleFonts.almarai(
              color: Colors.black,
              fontSize: getFontSize(context, 16),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blueAccent, width: 2),
            ),
            child: Text(
              'settings'.tr(),
              style: GoogleFonts.almarai(
                color: Colors.black,
                fontSize: getFontSize(context, 16),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppConfigurationScreen()),
            );
          },
        ),
        TextButton(
          child: Text(
            'close'.tr(),
            style: GoogleFonts.almarai(
              color: Colors.black,
              fontSize: getFontSize(context, 16),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
