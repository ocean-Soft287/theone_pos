import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theonepos/corec/sharde/consts.dart';
import 'package:theonepos/Features/main/setting/register/manager/register_cubit.dart';
import '../../../corec/constans/app_assets.dart';
import '../home/screen/home_screen.dart';
import '../setting/Login/screen/login_screen.dart';
import '../setting/register/model/device_model.dart';
import '../setting/register/register_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final DeviceInfoModel deviceInfoModel = DeviceInfoModel();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RegisterCubit>(
      context,
    ).checkDeviceActivate(activationCode: activeCode ?? '', context: context);

    Future.delayed(const Duration(seconds: 5), () {
      if (databaseName == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AppConfigurationScreen()),
        );
      } else if (userId == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff2B5083), Color(0xff2269A6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: -1, end: 0),
          duration: const Duration(seconds: 3),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value * MediaQuery.of(context).size.height),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Image.asset(AppAssets.splashLogo),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
