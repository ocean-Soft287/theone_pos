import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:theonepos/Corec/apis/endpoint.dart';
dynamic privateKey="0bddb58b52dc06e57d890cfe889e063a" ;

//ola= "0bddb58b52dc06e57d890cfe889e063a";//client
//= "df9d034fc11aac0f342beb7b129dad2e"; // production

dynamic publicKey="4d1f513ba676f7d2";
//= "849f29f1c07899fe"; production
dynamic authorization= Endpoint.authroization;

final String credentials = '$publicKey:$privateKey';

dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
  final keyObj = encrypt.Key.fromUtf8(privateKey);
  final ivObj = encrypt.IV.fromUtf8(publicKey); // 16 chars
  final encrypter = encrypt.Encrypter(
    encrypt.AES(keyObj, mode: encrypt.AESMode.cbc),
  );

  try {
    final decrypted = encrypter.decrypt(
      encrypt.Encrypted.fromBase64(encryptedText),
      iv: ivObj,
    );
    return decrypted;
  } catch (e) {
    return 'Error....................';
  }
}
String encryptData(
  Map<String, dynamic> data,
  String privateKey,
  String publicKey,
) {
  final key = encrypt.Key.fromUtf8(privateKey);
  final iv = encrypt.IV.fromUtf8(publicKey);
  final encrypter = encrypt.Encrypter(
    encrypt.AES(key, mode: encrypt.AESMode.cbc),
  );
  try {
    String jsonString = json.encode(data);
    final encrypted = encrypter.encrypt(jsonString, iv: iv);
    final encryptedText = encrypted.base64;
    return encryptedText;
  } catch (e) {
    return 'Error....................';
  }
}