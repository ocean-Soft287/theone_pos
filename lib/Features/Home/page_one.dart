import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dashboad/webView/screen/the_one_web_view_screen.dart';
import 'home_screen.dart';
import 'manager/setting_cubit.dart';
import 'manager/setting_state.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0048B5), Color(0xFF006EE5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: FadeInDown(
                  delay: const Duration(milliseconds: 10),
                  child: Image.asset(
                    'assets/images/icon21.jpg',
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Spacer(),

              _buildGuestLoginButton(context),
              const SizedBox(height: 10),
              BlocProvider(
                create: (context) => SettingViewCubit(),
                child: BlocConsumer<SettingViewCubit, SettingViewState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreenOne(),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            'Login with Fingerprint'.tr(),
                            style: GoogleFonts.tajawal(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuestLoginButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TheOneWebViewScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          "LoginGuest".tr(),
          textAlign: TextAlign.center,
          style: GoogleFonts.tajawal(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
