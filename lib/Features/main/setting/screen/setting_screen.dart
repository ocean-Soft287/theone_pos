import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theonepos/corec/sharde/font_responsive.dart';

import 'package:theonepos/Features/main/setting/contact_us/contact_us.dart';
import 'package:theonepos/Features/main/setting/register/register_screen.dart';

import '../../../../corec/sharde/app_colors.dart';
import '../../../../corec/sharde/consts.dart';

import '../register/manager/register_cubit.dart';
import '../register/manager/register_state.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  List<Map<dynamic, dynamic>> settingListComponent = [
    {'title': 'settings'.tr(), 'icon': 'assets/icons/settingIcon.svg'},
    {'title': 'update_databases'.tr(), 'icon': 'assets/icons/update_data.svg'},
    {'title': 'system_info'.tr(), 'icon': 'assets/icons/infoProg.svg'},
    {'title': 'download_images'.tr(), 'icon': 'assets/icons/downloadIma.svg'},
    {'title': 'deactivate'.tr(), 'icon': 'assets/icons/closeActive.svg'},
    {'title': 'system_reset'.tr(), 'icon': 'assets/icons/error.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 2 : 1;
    return Scaffold(
      backgroundColor: const Color(0xffE7EAEF),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xffE7EAEF),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 4,
              ),
              itemCount: settingListComponent.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (index == 4 || index == 5) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'system_reset'.tr(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'Madani',
                              ),
                            ),
                            content: Text(
                              'reset_system_confirmation'.tr(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'Madani',
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'cancel'.tr(),
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontFamily: 'Madani',
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: BlocConsumer<
                                  RegisterCubit,
                                  RegisterViewState
                                >(
                                  listener: (context, state) async {
                                    if (state is DeactivateCodeSuccess) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'deactivation_success'.tr(),
                                            style: GoogleFonts.alexandria(
                                              fontSize: getFontSize(
                                                context,
                                                16,
                                              ),
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.green,
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );

                                      await Hive.deleteFromDisk();
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.clear();
                                      await BlocProvider.of<RegisterCubit>(
                                        context,
                                      ).clearUserData();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  AppConfigurationScreen(),
                                        ),
                                      );
                                    }

                                    if (state is DeactivateCodeError) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'deactivation_error'.tr(),
                                            style: GoogleFonts.alexandria(
                                              fontSize: getFontSize(
                                                context,
                                                16,
                                              ),
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.red,
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );
                                    }
                                  },

                                  builder: (context, state) {
                                    return Text(
                                      'confirm'.tr(),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.mainAppColor,
                                        fontFamily: 'Madani',
                                      ),
                                    );
                                  },
                                ),
                                onPressed: () async {
                                  BlocProvider.of<RegisterCubit>(
                                    context,
                                  ).deviceDeactivate(
                                    activationCode: activeCode,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else if (index == 1) {
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactUsScreen(),
                        ),
                      );
                    }
                  },
                  child: Material(
                    color: Colors.white,
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(6.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            settingListComponent[index]['title'] ?? '',
                            maxLines: 2,
                            style: GoogleFonts.almarai(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff2269A6),
                            ),
                          ),
                          SvgPicture.asset(
                            settingListComponent[index]['icon'] ?? '',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUsScreen(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff2269A6),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(16),
                child: Image.asset('assets/images/conect.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
