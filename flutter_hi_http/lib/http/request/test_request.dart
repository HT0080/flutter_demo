import 'package:flutter_hi_http/http/request/base_request.dart';

class TestRequest extends BaseRequest{
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "uapi/test/test";
  }

}