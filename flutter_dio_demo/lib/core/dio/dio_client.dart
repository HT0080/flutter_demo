import 'package:dio/dio.dart';
import 'package:flutter_dio_demo/config/environment.dart';

Dio createDio() {
  return Dio(
    BaseOptions(
      baseUrl: EnvironmentConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ),
  );
}
