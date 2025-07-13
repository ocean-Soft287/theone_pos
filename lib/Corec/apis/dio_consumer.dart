import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/widgets.dart';
import 'package:theonepos/Corec/Extension/navigation.dart';
import 'package:theonepos/Corec/apis/keys.dart';
import 'api_consumer.dart';
import 'endpoint.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  late String basicAuth;

  DioConsumer({required this.dio}) {
    basicAuth =
        'Basic ${Keys.auth}';

    // Configure Dio options
    dio.options.baseUrl = Endpoint.mainbase;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language': NavigationService.getCurrentLocale() == Locale('en')?'en':'ar',
      'Authorization': basicAuth,
    };

    // Default Cache Interceptor (optional fallback)
    dio.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: MemCacheStore(),
          policy: CachePolicy.request,
          // Removed hitCacheOnErrorExcept - not needed in newer versions
          maxStale: const Duration(minutes: 30), // Default duration
          priority: CachePriority.high,
          keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        ),
      ),
    );

    // Enable logging
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool useCache = true, // New parameter to enable/disable cache
    Duration? cacheDuration, // New parameter to control duration
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          extra: {
            'cache': useCache, // Enable/disable caching
            if (useCache && cacheDuration != null)
              'maxStale': cacheDuration, // Custom duration if provided
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
      rethrow;
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data is FormData
            ? data
            : (isFromData ? FormData.fromMap(data) : data),
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
      rethrow;
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
      rethrow;
    }
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
      rethrow;
    }
  }

  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
      rethrow;
    }
  }

  void handleDioExceptions(DioException e) {
    if (e.response != null) {
    } else {}
  }
}
