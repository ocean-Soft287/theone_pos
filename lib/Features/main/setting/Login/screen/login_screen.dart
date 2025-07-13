import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:theonepos/corec/sharde/consts.dart';
import 'package:theonepos/Features/main/home/screen/home_screen.dart';
import 'package:theonepos/main.dart';

import '../../../../../corec/constans/app_assets.dart';
import '../../../../../corec/local/chacheHelper.dart';
import '../../../../../corec/sharde/app_colors.dart';
import '../../../../../corec/sharde/font_responsive.dart';
import '../../contact_us/contact_us.dart';
import '../../register/manager/register_cubit.dart';
import '../../register/manager/register_state.dart';
import '../../register/register_screen.dart';
import '../../../../../Corec/utils/widget/default_button.dart';
import '../widget/text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var keyForm = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterViewState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('حدث خطأ: ', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
        if (state is LoginSuccessState) {
          CacheHelper.saveData(key: 'UserID', value: state.data.userID);
          CacheHelper.saveData(
            key: 'FullUserName',
            value: state.data.fullUserName,
          );
          CacheHelper.saveData(
            key: 'accessHaveDiscount',
            value: state.data.haveDiscount,
          );

          userId = CacheHelper.getData(key: 'UserID');
          SellerName = CacheHelper.getData(key: 'FullUserName');
          accessHaveDiscount = CacheHelper.getData(key: 'accessHaveDiscount');

          print(userId);
          print(state.data);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        RegisterCubit blocCubit = BlocProvider.of<RegisterCubit>(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Form(
                    key: keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        40.verticalSpace,
                        Center(
                          child: Text(
                            'welcome'.tr(),

                            style: GoogleFonts.almarai(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 40,
                          ),
                          child: Center(
                            child: SvgPicture.asset(AppAssets.logo2),
                          ),
                        ),
                        25.verticalSpace,
                        Text(
                          'Login'.tr(),
                          style: GoogleFonts.almarai(
                            color: const Color(0xff2269A6),
                            fontSize: getFontSize(context, 16),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: CustomTextFormField(
                            hintText: 'username'.tr(),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'username'.tr();
                              }

                              return null;
                            },
                            controller: userNameController,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: CustomTextFormField(
                            hintText: 'password'.tr(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'password'.tr();
                              }

                              return null;
                            },
                            controller: passwordController,

                            subfix: IconButton(
                              onPressed: () {
                                BlocProvider.of<RegisterCubit>(
                                  context,
                                ).changIconPassword();
                              },
                              icon: Icon(
                                BlocProvider.of<RegisterCubit>(context).subfix,
                                color: AppColors.mainAppColor,
                                size: 25.0,
                              ),
                            ),
                            textInputType: TextInputType.visiblePassword,
                            obscureText:
                                BlocProvider.of<RegisterCubit>(
                                  context,
                                ).isPassword,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // showDialog(
                            //
                            //
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('enter_activation_code'.tr(),style: TextStyle(
                            //         fontSize: 10.sp,
                            //         fontWeight: FontWeight.w400,
                            //         color:Colors.black,
                            //         fontFamily: 'Madani',
                            //       ),),
                            //       content: Row(children: [
                            //         Expanded(
                            //           flex: 1,
                            //           child: CustomTextFormField(hintText: ''.tr(),
                            //
                            //             validator: (value) {
                            //
                            //               if (value == null || value.isEmpty) {
                            //                 return 'username'.tr();
                            //               }
                            //
                            //
                            //               return null;
                            //             },
                            //             controller: userNameController,
                            //
                            //
                            //
                            //
                            //           ),
                            //         ),
                            //         const SizedBox(width: 2,),
                            //         Expanded(
                            //           flex: 1,
                            //           child: CustomTextFormField(hintText: ''.tr(),
                            //
                            //             validator: (value) {
                            //
                            //               if (value == null || value.isEmpty) {
                            //                 return 'username'.tr();
                            //               }
                            //
                            //
                            //               return null;
                            //             },
                            //             controller: userNameController,
                            //
                            //
                            //
                            //
                            //           ),
                            //         ),
                            //         const SizedBox(width: 2,),
                            //         Expanded(
                            //           flex: 1,
                            //           child: CustomTextFormField(hintText: ''.tr(),
                            //
                            //             validator: (value) {
                            //
                            //               if (value == null || value.isEmpty) {
                            //                 return 'username'.tr();
                            //               }
                            //
                            //
                            //               return null;
                            //             },
                            //             controller: userNameController,
                            //
                            //
                            //
                            //
                            //           ),
                            //         ),
                            //         const SizedBox(width: 2,),
                            //         Expanded(
                            //           flex: 1,
                            //           child: CustomTextFormField(hintText: ''.tr(),
                            //
                            //             validator: (value) {
                            //
                            //               if (value == null || value.isEmpty) {
                            //                 return 'username'.tr();
                            //               }
                            //
                            //
                            //               return null;
                            //             },
                            //             controller: userNameController,
                            //
                            //
                            //
                            //
                            //           ),
                            //         ),
                            //
                            //       ],),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('cancel'.tr() ,style:  GoogleFonts.almarai(
                            //             fontSize: 15.sp,
                            //             fontWeight: FontWeight.bold,
                            //
                            //
                            //
                            //             color:Colors.grey,
                            //
                            //           ),),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //           },
                            //         ),
                            //         TextButton(
                            //           child: Text('confirm'.tr(), style: GoogleFonts.almarai(
                            //             fontSize: 15.sp,
                            //             fontWeight: FontWeight.bold,
                            //             color:AppColors.mainAppColor,
                            //
                            //           ),),
                            //           onPressed: () {
                            //
                            //           },
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'forgot_password'.tr(),
                              textAlign: TextAlign.left,

                              style: TextStyle(
                                color: Colors.red,
                                fontSize: getFontSize(context, 9),
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Madani',
                                decorationColor: Colors.red,
                                decorationThickness: 1.5,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                activeColor: const Color(0xff4F75FF),
                                checkColor: Colors.white,
                                value: blocCubit.checkBox,
                                onChanged: (bool? value) {
                                  blocCubit.changeCheckBox(
                                    check: blocCubit.checkBox,
                                  );
                                },
                              ),
                            ),

                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  'remember_me'.tr(),
                                  style: GoogleFonts.almarai(
                                    fontSize: getFontSize(context, 16),
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff4F75FF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder:
                              (context) => DefaultButton(
                                text: 'next'.tr(),
                                function: () {
                                  databaseName = CacheHelper.getData(
                                    key: 'databaseName',
                                  );
                                  print(databaseName);
                                  blocCubit.login(
                                    userName: userNameController.text,
                                    password: passwordController.text,
                                    serverName: ipAddress,
                                    serverPassword: passwordServer,
                                    serverUserName: userNameServer,
                                    dbName: databaseName,
                                  );
                                },
                                backgroundColor: const Color(0xff2269A6),
                              ),
                          fallback:
                              (context) => SizedBox(
                                height: 100,
                                width: 100.sh,
                                child: Center(
                                  child: Lottie.asset(
                                    'assets/images/loading.json',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        ),
                        5.verticalSpace,
                        DefaultButton(
                          text: 'register'.tr(),
                          function: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppConfigurationScreen(),
                              ),
                            );
                          },
                          backgroundColor: const Color(0xff2C4B7C),
                        ),
                        5.verticalSpace,
                        DefaultButton(
                          text: 'new_account_contact_us'.tr(),
                          function: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ContactUsScreen(),
                              ),
                            );
                          },
                          backgroundColor: const Color(0xff4DAF52),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
