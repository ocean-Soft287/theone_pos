import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/corec/local/chacheHelper.dart' show CacheHelper;
import 'package:theonepos/corec/sharde/consts.dart';
import 'package:theonepos/corec/sharde/font_responsive.dart' show getFontSize;
import 'package:theonepos/Features/main/setting/Login/screen/login_screen.dart'
    show LoginScreen;

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 60,
                color: Colors.red,
              ),
              const SizedBox(height: 15),
              Text(
                'logout_confirmation'.tr(),
                style: GoogleFonts.alexandria(
                  fontSize: getFontSize(context, 16),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'cancel'.tr(),
                      style: GoogleFonts.alexandria(color: Colors.grey),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await CacheHelper.removeData(key: 'UserID');
                      await CacheHelper.removeData(key: 'FullUserName');
                      userId = CacheHelper.getData(key: 'UserID');
                      SellerName = CacheHelper.getData(key: 'FullUserName');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'confirm'.tr(),
                      style: GoogleFonts.alexandria(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
