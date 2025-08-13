import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Dio createDio() {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.github.com/',
    // Slightly tighter to fail fast during startup flows
    connectTimeout: const Duration(seconds: 6),
    receiveTimeout: const Duration(seconds: 6),
    headers: {
      'Accept': 'application/vnd.github+json',
    },
  ));
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(responseBody: false, requestBody: false));
  }
  return dio;
}
