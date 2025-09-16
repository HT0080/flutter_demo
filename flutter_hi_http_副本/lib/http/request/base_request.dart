import 'package:flutter_hi_http/http/dao/login_dao.dart';

enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  var pathParams; // 参数
  var useHttps = true; // 使用HTTPS 默认
  // 域名
  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();
  String path();
  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接path 参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    // http 和HTTPS 切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    if(needLogin()){
      // 需要登录的接口，获取登录令牌
      addHeader(LoginDao.BOADRDING_PASS, LoginDao.getBoadingPass());
    }
    return uri.toString();
  }

  bool needLogin(); // 是否需要登录
  // 请求参数
  Map<String, String> params = Map();
  //添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  // 请求头参数
  Map<String, dynamic> header = {
    'course-flag':'fa',
    'auth-token':'MjAyMC0wNi0yMyAwMzoyNTowMQ==fa',
  };
  //添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
