import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:theonepos/Features/Home/manager/setting_state.dart';

import '../../../corec/local/chacheHelper.dart';

import '../home_screen.dart';

class SettingViewCubit extends Cubit<SettingViewState> {
  SettingViewCubit() : super(InitializeSettingState());

  bool switchLocalAuth = CacheHelper.getData(key: 'switchLocalAuth');

  void changeSwitchLocalAuth({required bool value}) {
    if (switchLocalAuth) {
      CacheHelper.saveData(key: 'switchLocalAuth', value: false);
    } else {
      CacheHelper.putData(key: 'switchLocalAuth', value: true);
    }

    switchLocalAuth = value;
    emit(SwitchLockAuth());
  }

  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> authenticate(context) async {
    emit(LoginAuthFingerprintLoading());
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (authenticated) {
        emit(LoginAuthFingerprintSuccess());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreenOne()),
        );
      } else {
        emit(LoginAuthFingerprintError());
      }
    } catch (e) {}
  }
}
