import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;

  RetryInterceptor({required this.dio, this.maxRetries = 3});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    int retryCount = err.requestOptions.extra['retry_count'] ?? 0;
    if (retryCount < maxRetries && _shouldRetry(err)) {
      retryCount++;
      err.requestOptions.extra['retry_count'] = retryCount;

      // 指数退避策略，避免立即重试可能持续失败的请求
      final delay = Duration(milliseconds: 300 * (1 << retryCount));
      print(
        'Retry request (${retryCount}/${maxRetries}) after ${delay.inMilliseconds}ms',
      );
      await Future.delayed(delay);

      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.next(e as DioException);
      }
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        (err.response?.statusCode != null &&
            err.response!.statusCode! >= 500); // 服务器错误可以重试
  }
}
