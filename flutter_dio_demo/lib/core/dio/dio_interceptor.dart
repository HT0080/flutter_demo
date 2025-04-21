
import 'package:dio/dio.dart';
import 'package:flutter_dio_demo/core/dio/dio_exceptions.dart';

class DioInterceptor extends Interceptor{
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);

    // 添加token等
    // options.headers['Authorization'] = 'Bearer your_token';
    // return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    final customError = DioExceptions.fromDioError(err);
    return handler.reject(customError);
  }

}