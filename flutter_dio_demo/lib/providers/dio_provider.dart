import 'package:flutter_dio_demo/core/dio/auth_interceptor.dart';
import 'package:flutter_dio_demo/core/dio/dio_client.dart';
import 'package:flutter_dio_demo/core/dio/dio_interceptor.dart';
import 'package:flutter_dio_demo/core/dio/retry_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref){
  final dio = createDio();
  dio.interceptors.addAll([
    AuthInterceptor(dio),
    RetryInterceptor(dio: dio),
    DioInterceptor(),
  ]);
  return dio;
});

