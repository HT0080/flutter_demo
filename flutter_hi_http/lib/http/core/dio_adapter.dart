import 'package:dio/dio.dart';
import 'package:flutter_hi_http/http/core/hi_error.dart';
import 'package:flutter_hi_http/http/core/hi_net_adapter.dart';
import 'package:flutter_hi_http/http/request/base_request.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response, option = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(
          request.url(), 
          options: option
          );
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio().post(
          request.url(),
          data: request.params,
          options: option,
        );
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio().delete(
          request.url(),
          data: request.params,
          options: option,
        );
      }
    } on DioException catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      throw HiNetError(
        response?.statusCode ?? -1,
        error.toString(),
        data: buildRes(response, request),
      );
    }
    return buildRes(response, request);
  }

  // touj
  HiNetResponse<T> buildRes<T>(Response response, BaseRequest request) {
    return HiNetResponse<T>(
      data: response.data,
      request: request,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response,
    );
  }
}
