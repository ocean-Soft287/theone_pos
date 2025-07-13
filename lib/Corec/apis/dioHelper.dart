import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:theonepos/Corec/apis/endpoint.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    lineLength: 80,
    errorMethodCount: 8,
    colors: true,
    printEmojis: true,
  ),
);

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(baseUrl: Endpoint.mainbase, receiveDataWhenStatusError: true),
    );

    // Add custom interceptor
    dio.interceptors.add(CustomLoggerInterceptor());
    dio.interceptors.add(LogInterceptor(
  requestBody: true,
  responseBody: true,
));

    // Optional: Add Dio's default logger (remove if CustomLoggerInterceptor is used)
    // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  static Future<Response> getData({
    required String url,
    String? outerToken,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Accept-Language': 'ar',
      'Authorization': 'Basic ${Endpoint.authroization}',
    };

    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> updateData({
    required String url,
    required dynamic data,
  }) async {
    dio.options.headers = {
      'Authorization': 'Basic ${Endpoint.authroization}',
      'Content-Type': 'application/json',
    };

    return await dio.put(url, data: data);
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
  }) async {
    dio.options.headers = {
      'Authorization': 'Basic ${Endpoint.authroization}',
    };

    return dio.post(url, data: data);
  }

  static Future<Response> delete({required String url}) async {
    dio.options.headers = {
      'Authorization': 'Basic ${Endpoint.authroization}',
      'Content-Type': 'application/json',
    };

    return dio.delete(url);
  }
}

class CustomLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i("🟩 [REQUEST] => ${options.method} ${options.path}");
    logger.d("Headers: ${options.headers}");
    
    if (options.data != null) {
      logger.d("Body:\n${_prettyJson(options.data)}");
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i("🟦 [RESPONSE] <= STATUS: ${response.statusCode}");
    logger.d("Headers: ${response.headers.map}");

    if (response.data != null) {
      logger.d("Data:\n${_prettyJson(response.data)}");
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e("🟥 [ERROR] => MESSAGE: ${err.message}");

    if (err.response != null) {
      logger.e("Status Code: ${err.response?.statusCode}");
      if (err.response?.data != null) {
        logger.e("Error Data:\n${_prettyJson(err.response?.data)}");
      }
    }

    super.onError(err, handler);
  }

  String _prettyJson(dynamic data) {
    try {
      if (data is String) return data;
      final pretty = JsonEncoder.withIndent('  ').convert(data);
      return pretty;
    } catch (e) {
      return data.toString();
    }
  }
}