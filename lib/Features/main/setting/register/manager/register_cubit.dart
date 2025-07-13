import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theonepos/corec/apis/dioHelper.dart';
import 'package:theonepos/Features/main/setting/register/manager/register_state.dart';

import '../../../../../corec/apis/encrupt.dart';
import '../../../../../corec/local/chacheHelper.dart';
import '../../../../../corec/sharde/consts.dart';
import '../../../../../main.dart';
import '../model/activation_model.dart';
import '../model/device_model.dart';
import '../model/user_model.dart';

class RegisterCubit extends Cubit<RegisterViewState> {
  RegisterCubit() : super(InitializeRegisterState());

  bool checkVisibility = true;
  int changeIndex = 0;
  void checkVisibilityFun({required bool check, required int index}) {
    changeIndex = index;
    emit(ChangeCheckState());
  }

  bool checkBox = false;
  bool checkBox2 = false;
  void changeCheckBox({required bool check}) {
    checkBox = !checkBox;
    emit(ChangeCheckBoxState());
  }

  List<Map<String, dynamic>> dataBaseList = [];
  void getNameDataBase({
    required String serverName,
    required String userName,
    required String userPassword,
  }) {
    emit(GetNameDataBaseLoadingState());
    DioHelper.getData(
          url: 'api/GetConfigDataBases',
          query: {
            'serverName': serverName,
            'UserName': userName,
            'UserPassword': userPassword,
          },
        )
        .then((value) {
          var valueDataBase = decrypt(value.data, privateKey, publicKey);

          dataBaseList =
              (json.decode(valueDataBase) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();

          emit(GetNameDataBaseSuccessState());
        })
        .catchError((error) {
          print("xxx");
          print(error.toString());
          emit(GetNameDataBaseErrorState());
        });
  }

  List<UserModel> dataUserLogin = [];
  int? haveaccount;
  String? username;
  void login({
    required String userName,
    required String password,

    required String serverName,
    required String serverUserName,
    required String serverPassword,
    required String dbName,
  }) {
    String encryptedData = encryptData(
      {
        "UserName": userName,
        "PassWord": password,
        "serverName": serverName,
        "DBName": dbName,
        "serverUserName": serverUserName,
        "serverPassword": serverPassword,
      },
      privateKey,
      publicKey,
    );
    String jsonData = jsonEncode(encryptedData);
    print(jsonData);
    dynamic a = decrypt(encryptedData, privateKey, publicKey);
    print(a);
    emit(LoginLoadingState());
    DioHelper.postData(url: 'api/Users/Login', data: jsonData)
        .then((value) async {
          var valueDataBase = decrypt(value.data, privateKey, publicKey);

          List<dynamic> jsonList = jsonDecode(valueDataBase);
          dataUserLogin =
              jsonList.map((json) => UserModel.fromJson(json)).toList();

          final dataLogin =
              (json.decode(valueDataBase) as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList();
          haveaccount = dataUserLogin[0].haveDiscount ?? 0;
          username = dataUserLogin[0].userName;
          //username=dataUserLogin[0].fullUserName;
          await CacheHelper.saveData(
            key: "haveDiscountValue",
            value: haveaccount,
          );
          await CacheHelper.saveData(key: "name", value: username);
          final name = CacheHelper.getData(key: "name");
          //       print(dataLogin);
          // print(name);
          print(dataUserLogin);
          emit(LoginSuccessState(dataUserLogin[0]));
        })
        .catchError((error) {
          print(error.toString());
          emit(LoginErrorState());
        });
  }

  TextEditingController controllerIpAddress = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  TextEditingController privateKeyController = TextEditingController();
  TextEditingController publicKeyController = TextEditingController();
  TextEditingController authorizationController = TextEditingController();

  bool isPassword = true;
  IconData subfix = Icons.visibility_off;
  void changIconPassword() {
    isPassword = !isPassword;
    subfix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ChangeIconPasswordSuccess());
  }

  final dio = Dio();
  ActivationModel? activationModel;
  List<ActivationModel> dataActiveCode = [];
  Future<void> checkActivationCode({
    required String key1,
    required String key2,
    required String key3,
    required String key4,
    required String deviceCode,
    required String deviceWifiMAC,
    required String deviceModel,
    required String deviceName,
    required String deviceIMEI,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': 'ar',
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ==',
    };

    emit(CheckActivationCodeLoading());

    try {
      String jsonData = jsonEncode({
        "ActivationCode": "$key1-$key2-$key3-$key4",
        "DeviceCode": deviceCode,
        "DeviceTypeID": 1,
        "DeviceWifiMAC": deviceWifiMAC,
        "DeviceModel": deviceModel,
        "DeviceName": deviceName,
        "DeviceIMEI": deviceIMEI,
        "DeviceToken": "DeviceToken",
      });

      print("$key1-$key2-$key3-$key4");

      var response = await dio.get(
        'http://15.235.51.177/TheOneAPI/api/GetDeviceConfigV2?'
        'ActivationCode=$key1-$key2-$key3-$key4'
        '&DeviceCode=$deviceCode'
        '&DeviceTypeID=1'
        '&DeviceWifiMAC=$deviceWifiMAC'
        '&DeviceModel=$deviceModel'
        '&DeviceName=$deviceName'
        '&DeviceIMEI=$deviceIMEI'
        '&DeviceToken=DeviceToken',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print(response.data);
        final responseData = json.decode(response.data);
        print(responseData);
        // التحقق إذا كان الرد يحتوي على الرسالة المطلوبة
        if (response.data.contains(
          "No Configuration was found for this Serial.",
        )) {
          print('No Configuration was found for this Serial.');
          emit(CheckActivationCodeError());
        } else {
          List<dynamic> jsonList = responseData;
          dataActiveCode =
              jsonList.map((json) => ActivationModel.fromJson(json)).toList();
          print("Data processed successfully: $dataActiveCode");
          CacheHelper.saveData(
            key: 'activeCode',
            value: "$key1-$key2-$key3-$key4",
          );
          activeCode = CacheHelper.getData(key: 'activeCode');
          print('gggggg $activeCode');
          emit(CheckActivationCodeSuccess());
        }

        // طباعة البيانات والمخرجات
        print(response.data);
      }
    } catch (error) {
      print(error.toString());
      emit(CheckActivationCodeError());
    }
  }

  Future<void> deviceDeactivate({required String activationCode}) async {
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': 'ar',
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ==',
    };
    emit(DeactivateCodeLoading());
    try {
      final response = await dio.get(
        'http://15.235.51.177/TheOneAPI/api/DeviceDeactivate',
        queryParameters: {'ActivationCode': activationCode},
        options: Options(headers: headers),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        // Assuming the response contains a success message
        if (response.data.contains(
          "No Configuration was found for this Activation Code.",
        )) {
          // emit(DeactivateCodeError('No Configuration was found for this Activation Code.'));

          emit(DeactivateCodeSuccess('Deactivation successful'));
        } else {
          emit(DeactivateCodeSuccess('Deactivation successful'));
        }
      } else {}
    } catch (error) {
      print(error.toString());
      print('1111111111111111111111');
      print(error.toString());
      emit(DeactivateCodeError(error.toString()));
    }
  }

  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  final focusNode4 = FocusNode();
  TextEditingController key1ActiveCodeController = TextEditingController();
  TextEditingController key2ActiveCodeController = TextEditingController();
  TextEditingController key3ActiveCodeController = TextEditingController();
  TextEditingController key4ActiveCodeController = TextEditingController();
  void moveToNextField(
    String value,
    FocusNode currentNode,
    FocusNode? nextNode,
  ) {
    if (value.length == 4) {
      if (nextNode != null) {
        nextNode.requestFocus();
      } else {
        currentNode.unfocus();
      }
    }
  }

  @override
  Future<void> close() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    return super.close();
  }

  void pasteCode(String value) {
    final parts = value.split('-');

    if (parts.isNotEmpty) key1ActiveCodeController.text = parts[0];
    if (parts.length > 1) key2ActiveCodeController.text = parts[1];
    if (parts.length > 2) key3ActiveCodeController.text = parts[2];
    if (parts.length > 3) key4ActiveCodeController.text = parts[3];

    if (parts.isNotEmpty && parts[0].isNotEmpty) focusNode2.requestFocus();
    if (parts.length > 1 && parts[1].isNotEmpty) focusNode3.requestFocus();
    if (parts.length > 2 && parts[2].isNotEmpty) focusNode4.requestFocus();
  }

  final DeviceInfoModel deviceInfoModel = DeviceInfoModel();
  Future<void> checkDeviceActivate({
    required String activationCode,

    required BuildContext context,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': 'ar',
      'Authorization':
          'Basic ZTBjOWRlMWIyZGUyNmZlMjpnOEV0eXg4VFU1Nzl2RHhKemFOMWxvM3I0NitXSkx2cWIvSU1ZZElVUkhNPQ==',
    };
    await deviceInfoModel.getDeviceAndWifiInfo(context: context);
    print('********************************************');
    print(deviceInfoModel.deviceCode);
    print(activationCode);
    print('*****************************************');
    emit(CheckDeviceActivateLoading());

    try {
      final response = await dio.get(
        'http://15.235.51.177/TheOneAPI/api/CheckDeviceActivate',
        queryParameters: {
          'ActivationCode': activationCode,
          'DeviceCode': deviceInfoModel.deviceCode.toString(),
          'DeviceTypeID': 1,
          'DeviceWifiMAC': deviceInfoModel.wifiMacAddress.toString(),
          'DeviceModel':
              (Theme.of(context).platform == TargetPlatform.android)
                  ? deviceInfoModel.deviceModel.toString()
                  : deviceInfoModel.deviceModel.toString(),
          'DeviceName':
              (Theme.of(context).platform == TargetPlatform.android)
                  ? deviceInfoModel.deviceName.toString()
                  : deviceInfoModel.iosName.toString(),
          'DeviceIMEI': deviceInfoModel.deviceName.toString(),
          'DeviceToken': '',
        },
        options: Options(headers: headers),
      );

      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        print(response.data);

        if (response.data == "True") {
          emit(CheckDeviceActivateSuccess(true));
        } else {
          await CacheHelper.removeData(key: 'UserID');
          await CacheHelper.removeData(key: 'FullUserName');
          await CacheHelper.removeData(key: 'ipAddress');
          await CacheHelper.removeData(key: 'privateKey');
          await CacheHelper.removeData(key: 'publicKey');
          await CacheHelper.removeData(key: 'authorization');
          await CacheHelper.removeData(key: 'activeCode');
          await CacheHelper.removeData(key: 'databaseName');
          databaseName = CacheHelper.getData(key: 'databaseName');
          // await CacheHelper.removeData(key:'baseUrl');

          userId = CacheHelper.getData(key: 'UserID');
          SellerName = CacheHelper.getData(key: 'FullUserName');
          activeCode = CacheHelper.getData(key: 'activeCode');
          print(activeCode);
          ipAddress = CacheHelper.getData(key: 'ipAddress');
          privateKey = CacheHelper.getData(key: 'privateKey');
          publicKey = CacheHelper.getData(key: 'publicKey');
          authorization = CacheHelper.getData(key: 'authorization');

          emit(CheckDeviceActivateError(false));
        }
      } else {
        emit(CheckDeviceActivateError(false));
      }
    } catch (error) {
      print(error.toString());
      emit(CheckDeviceActivateError(false));
    }
  }

  Future<void> clearUserData() async {
    await Future.wait([
      CacheHelper.removeData(key: 'UserID'),
      CacheHelper.removeData(key: 'FullUserName'),
      CacheHelper.removeData(key: 'ipAddress'),
      CacheHelper.removeData(key: 'privateKey'),
      CacheHelper.removeData(key: 'publicKey'),
      CacheHelper.removeData(key: 'authorization'),
      CacheHelper.removeData(key: 'activeCode'),
      // await CacheHelper.removeData(key:'baseUrl');
    ]);

    userId = null;
    SellerName = null;
    activeCode = null;
    ipAddress = null;
    privateKey = null;
    publicKey = null;
    authorization = null;
    key4ActiveCodeController.clear();
    key3ActiveCodeController.clear();
    key2ActiveCodeController.clear();
    key1ActiveCodeController.clear();
    passwordController.clear();
    controllerIpAddress.clear();
    userNameController.clear();
  }
}
