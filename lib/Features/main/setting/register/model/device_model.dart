// device_info_model.dart
import 'package:device_info_plus/device_info_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:flutter/material.dart';

// مكتبة للحصول على IMEI في Android

class DeviceInfoModel {
  String? wifiMacAddress;
  String? deviceBrand;
  String? deviceModel;
  String? deviceName;
  String? deviceCode; // Device Code (الذي يمثل معرف الجهاز الفريد)
  String? deviceIMEI; // IMEI أو ما يعادله في iOS
  String? androidVersion;
  String? iosDevice;
  String? iosVersion;
  String? iosName;
  String? iosSystemVersion;

  Future<void> getDeviceAndWifiInfo({required BuildContext context}) async {
    final info = NetworkInfo();
    final deviceInfo = DeviceInfoPlugin();

    wifiMacAddress = await info.getWifiBSSID();
    print('Wi-Fi MAC Address: $wifiMacAddress');

    if (Theme.of(context).platform == TargetPlatform.android) {
      final androidInfo = await deviceInfo.androidInfo;

      deviceBrand = androidInfo.brand;
      deviceModel = androidInfo.model;
      deviceName = androidInfo.device;
      deviceCode = androidInfo.id;
      androidVersion = androidInfo.version.release;

      print('--- Android Device Info ---');
      print('Brand: $deviceBrand');
      print('Model: $deviceModel');
      print('Device Name: $deviceName');
      print('Device Code (Android ID): $deviceCode');
      print('Device IMEI: $deviceIMEI');
      print('Android Version: $androidVersion');
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      final iosInfo = await deviceInfo.iosInfo;

      iosDevice = iosInfo.utsname.machine;
      iosVersion = iosInfo.systemVersion;
      iosName = iosInfo.name;
      iosSystemVersion = iosInfo.systemVersion;

      deviceCode = wifiMacAddress;
      deviceName = iosInfo.name;
      deviceIMEI = "IMEI not available on iOS";

      print('--- iOS Device Info ---');
      print('Device: $iosDevice');
      print('iOS Version: $iosVersion');
      print('Device Name: $iosName');
      print('Device Code (MAC Address): $deviceCode');
      print('Device IMEI: $deviceIMEI');
      print('System Version: $iosSystemVersion');
    }
  }
}
