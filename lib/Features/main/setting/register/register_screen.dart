import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theonepos/Features/main/setting/Login/screen/login_screen.dart';
import 'package:theonepos/Features/main/setting/register/widgets/load_settings_widget.dart';
import '../../../../corec/apis/encrupt.dart';

import '../../../../corec/local/chacheHelper.dart';

import '../../../../corec/sharde/app_colors.dart';
import '../../../../corec/sharde/consts.dart';
import '../../../../corec/sharde/font_responsive.dart';
import '../../../../corec/utils/widget/custom_text_field.dart';
import '../../../../main.dart';

import '../Login/widget/text_form_field.dart';
import 'manager/register_cubit.dart';
import 'manager/register_state.dart';
import 'model/device_model.dart';

class AppConfigurationScreen extends StatelessWidget {
  final DeviceInfoModel deviceInfoModel = DeviceInfoModel();
  AppConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (privateKey == null && publicKey == null && authorization == null) {
      deviceInfoModel.getDeviceAndWifiInfo(context: context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,

          builder: (BuildContext context) {
            final cubit = BlocProvider.of<RegisterCubit>(context);
            return BlocConsumer<RegisterCubit, RegisterViewState>(
              listener: (context, state) {
                if (state is CheckActivationCodeSuccess) {
                  CacheHelper.saveData(
                    key: 'publicKey',
                    value: cubit.dataActiveCode[0].publicKey,
                  );
                  CacheHelper.saveData(
                    key: 'privateKey',
                    value: cubit.dataActiveCode[0].privateKey,
                  );
                  CacheHelper.saveData(
                    key: 'authorization',
                    value: cubit.dataActiveCode[0].authorization,
                  );
                  //  CacheHelper.saveData(key: 'baseUrl', value:cubit.dataActiveCode[0]);

                  privateKey = CacheHelper.getData(key: 'privateKey');
                  publicKey = CacheHelper.getData(key: 'publicKey');
                  authorization = CacheHelper.getData(key: 'authorization');
                  // baseUrl=CacheHelper.getData(key: 'baseUrl');

                  Navigator.of(context).pop();
                }
                if (state is CheckActivationCodeError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,

                      content: Text('no_configuration_found'.tr()),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              builder: (BuildContext context, RegisterViewState state) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    'enter_activation_code'.tr(),
                    style: GoogleFonts.almarai(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  content: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextFormField(
                          hintText: 'KEY 1'.tr(),
                          focusNode: cubit.focusNode1,
                          controller: cubit.key1ActiveCodeController,
                          onChanged: (value) {
                            cubit.pasteCode(value);
                            cubit.moveToNextField(
                              value,
                              cubit.focusNode1,
                              cubit.focusNode2,
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'KEY 1'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 1),
                      Expanded(
                        flex: 1,
                        child: CustomTextFormField(
                          hintText: 'KEY 2'.tr(),
                          focusNode: cubit.focusNode2,
                          controller: cubit.key2ActiveCodeController,
                          onChanged: (value) {
                            cubit.moveToNextField(
                              value,
                              cubit.focusNode2,
                              cubit.focusNode3,
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'KEY 2'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 1),
                      Expanded(
                        flex: 1,
                        child: CustomTextFormField(
                          hintText: 'KEY 3'.tr(),
                          focusNode: cubit.focusNode3,
                          controller: cubit.key3ActiveCodeController,
                          onChanged: (value) {
                            cubit.moveToNextField(
                              value,
                              cubit.focusNode3,
                              cubit.focusNode4,
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'KEY 3'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 1),
                      Expanded(
                        flex: 1,
                        child: CustomTextFormField(
                          hintText: 'KEY 4'.tr(),
                          focusNode: cubit.focusNode4,
                          controller: cubit.key4ActiveCodeController,
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'KEY 4'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    ConditionalBuilder(
                      condition: state is! CheckActivationCodeLoading,
                      builder: (context) {
                        return TextButton(
                          child: Text(
                            'confirm'.tr(),
                            style: GoogleFonts.almarai(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainAppColor,
                            ),
                          ),
                          onPressed: () {
                            cubit.checkActivationCode(
                              key1: cubit.key1ActiveCodeController.text,
                              key2: cubit.key2ActiveCodeController.text,
                              key3: cubit.key3ActiveCodeController.text,
                              key4: cubit.key4ActiveCodeController.text,
                              deviceCode:
                                  (Theme.of(context).platform ==
                                          TargetPlatform.android)
                                      ? deviceInfoModel.deviceCode.toString()
                                      : deviceInfoModel.iosName.toString(),
                              deviceIMEI: deviceInfoModel.deviceName.toString(),
                              deviceModel:
                                  (Theme.of(context).platform ==
                                          TargetPlatform.android)
                                      ? deviceInfoModel.deviceModel.toString()
                                      : deviceInfoModel.deviceModel.toString(),
                              deviceName:
                                  (Theme.of(context).platform ==
                                          TargetPlatform.android)
                                      ? deviceInfoModel.deviceName.toString()
                                      : deviceInfoModel.iosName.toString(),
                              deviceWifiMAC:
                                  deviceInfoModel.wifiMacAddress.toString(),
                            );
                          },
                        );
                      },
                      fallback: (context) {
                        return CircularProgressIndicator(
                          color: AppColors.mainAppColor,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    TextButton(
                      child: Text(
                        'cancel'.tr(),
                        style: GoogleFonts.almarai(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      onPressed: () {
                        // String dd= encryptData( {"ActivationCode":"B006-1DF5-9036-4DD5",
                        //   "DeviceCode":"DeviceCode","DeviceTypeID":1,
                        //   "DeviceWifiMAC":"DeviceWifiMAC",
                        //   "DeviceModel":"DeviceModel","DeviceName":"DeviceName",
                        //   "DeviceIMEI":"DeviceIMEI","DeviceToken":"DeviceToken"}, privateKey, publicKey);
                        //
                        //     print(dd);
                        SystemNavigator.pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: login_app_bar(context),
      body: BlocConsumer<RegisterCubit, RegisterViewState>(
        listener: login_listener,
        builder: (context, state) {
          RegisterCubit blocCubit = BlocProvider.of<RegisterCubit>(context);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      print(privateKey);
                      print(publicKey);
                      print(authorization);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/setting.svg',
                      height: 150.h,
                    ),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    onChanged: (value) {
                      ipAddress = value;
                    },
                    textColor: Colors.black,
                    controller: blocCubit.controllerIpAddress,
                    labelText: 'Ip Address',
                    hintColor: Colors.black26,
                    labelColor: Colors.black,
                    hintText: '',
                    enableColor: const Color(0xffE7EAEF),
                    fillColor: const Color(0xffE7EAEF),
                    focusedColor: const Color(0xff2269A6),
                  ),
                  5.verticalSpace,
                  CustomTextField(
                    textColor: Colors.black,
                    controller: blocCubit.userNameController,
                    labelText: 'User Name',
                    labelColor: Colors.black,
                    hintColor: Colors.black26,
                    hintText: '',
                    enableColor: const Color(0xffE7EAEF),
                    fillColor: const Color(0xffE7EAEF),
                    focusedColor: const Color(0xff2269A6),
                  ),
                  5.verticalSpace,
                  CustomTextField(
                    textColor: Colors.black,
                    controller: blocCubit.passwordController,
                    labelText: 'Password',
                    labelColor: Colors.black,
                    hintColor: Colors.black26,
                    hintText: '',
                    enableColor: const Color(0xffE7EAEF),
                    fillColor: const Color(0xffE7EAEF),
                    focusedColor: const Color(0xff2269A6),
                  ),
                  50.verticalSpace,
                  LoadSettingsWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void login_listener(context, state) {
    if (state is GetNameDataBaseSuccessState) {
      CacheHelper.saveData(
        key: 'ipAddress',
        value: BlocProvider.of<RegisterCubit>(context).controllerIpAddress.text,
      );
      CacheHelper.saveData(
        key: 'userName',
        value: BlocProvider.of<RegisterCubit>(context).userNameController.text,
      );
      CacheHelper.saveData(
        key: 'password',
        value: BlocProvider.of<RegisterCubit>(context).passwordController.text,
      );

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount:
                        BlocProvider.of<RegisterCubit>(
                          context,
                        ).dataBaseList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          BlocProvider.of<RegisterCubit>(
                            context,
                          ).checkVisibilityFun(check: false, index: index);
                          await CacheHelper.saveData(
                            key: 'databaseName',
                            value:
                                BlocProvider.of<RegisterCubit>(
                                  context,
                                ).dataBaseList[BlocProvider.of<RegisterCubit>(
                                  context,
                                ).changeIndex]['DBName'] ??
                                databaseName,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            BlocProvider.of<RegisterCubit>(
                              context,
                            ).dataBaseList[index]['ArabicDBName'],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.almarai(
                              fontSize: getFontSize(context, 16),
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: Colors.grey[300], thickness: 1);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );

      ipAddress = CacheHelper.getData(key: 'ipAddress');
      userNameServer = CacheHelper.getData(key: 'userName');
      passwordServer = CacheHelper.getData(key: 'password');
    }
    if (state is GetNameDataBaseErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حدث خطأ: ', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  AppBar login_app_bar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffFFFFFF),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      ),
    );
  }
}
