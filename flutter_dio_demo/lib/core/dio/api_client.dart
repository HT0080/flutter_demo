import 'package:dio/dio.dart';
import 'package:flutter_dio_demo/core/dio/base_response.dart';
import 'package:flutter_dio_demo/core/dio/http_method.dart';
import 'package:flutter_dio_demo/providers/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

class ApiClient {
  final Dio _dio;
  ApiClient(this._dio);

  Future<BaseResponse<T>> request<T>(
    String path, {
    HttpMethod method = HttpMethod.get,
    dynamic data,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    FromJson<T>? fromJson,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(method: method.name),
        cancelToken: cancelToken,
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleError<T>(e);
    }
  }
  void cancelRequest(CancelToken token){
    if(!token.isCancelled){
      token.cancel("请求被取消");
    }
  }

  BaseResponse<T> _handleResponse<T>(Response response, FromJson<T>? fromJson) {
    final json = response.data;
    if (fromJson != null) {
      return BaseResponse<T>.fromJson(json, fromJson);
    }
    return BaseResponse.fromJson(json, (json) => json as T);
  }

  BaseResponse<T> _handleError<T>(DioException e) {
    return BaseResponse<T>(
      code: e.response?.statusCode ?? 500,
      message: e.message ?? "未知错误",
    );
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
});
