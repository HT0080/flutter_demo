import 'package:flutter_hi_http/http/core/dio_adapter.dart';
import 'package:flutter_hi_http/http/core/hi_error.dart';
import 'package:flutter_hi_http/http/core/hi_net_adapter.dart';
import 'package:flutter_hi_http/http/core/mock_adapter.dart';
import 'package:flutter_hi_http/http/request/base_request.dart';

class HiNet {
  HiNet._();
  static final HiNet _instance = HiNet._();
  static HiNet getInstance() => _instance;

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }

    var result = response?.data;
    printLog(result);

    var status = response?.statusCode??-1;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url:${request.url()}');
    printLog('method:${request.httpMethod()}');

    // request.addHeader('token', '123');
    // printLog('header:${request.header}');

    // return Future.value({
    //   "statusCode": 200,
    //   "data": {"code": 0, "message": 'success'},
    // });

    // // 使用mock 发送请求
    HiNetAdapter adapter = MockAdapter();
    return adapter.send(request);
    // dio 
    // HiNetAdapter adapter = DioAdapter();
    // return adapter.send(request);
  }

  void printLog(log) {
    print('hi_net:${log.toString()}');
  }
}
