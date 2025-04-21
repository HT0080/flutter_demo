import 'package:dio/dio.dart';

class DioExceptions extends DioException {
  final String message;
  DioExceptions({required this.message, required RequestOptions requestOptions})
    : super(
        requestOptions: requestOptions,
        error: message,
        type: DioExceptionType.unknown,
      );

  factory DioExceptions.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DioExceptions(
          message: "连接超时",
          requestOptions: error.requestOptions,
        );
      case DioExceptionType.receiveTimeout:
        return DioExceptions(
          message: "响应超时",
          requestOptions: error.requestOptions,
        );
      case DioExceptionType.sendTimeout:
        return DioExceptions(
          message: "请求超时",
          requestOptions: error.requestOptions,
        );
      case DioExceptionType.badResponse:
        return DioExceptions(
          message: "服务器错误",
          requestOptions: error.requestOptions,
        );
      default:
        return DioExceptions(
          message: "未知错误",
          requestOptions: error.requestOptions,
        );
    }
  }
@override
  String toString() {
    return message;
  }

}
