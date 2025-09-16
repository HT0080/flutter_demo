import 'package:flutter_hi_http/db/hi_cache.dart';
import 'package:flutter_hi_http/http/core/hi_net.dart';
import 'package:flutter_hi_http/http/request/base_request.dart';
import 'package:flutter_hi_http/http/request/login_request.dart';
import 'package:flutter_hi_http/http/request/registration_request.dart';

/// 数据交互
class LoginDao {
  static const BOADRDING_PASS = "boarding-pass";

  static login(String username, String password) {
    return _send(username, password);
  }

  static registration(
    String username,
    String password,
    String imoocId,
    String orderId,
  ) {
    return _send(username, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(
    String username,
    String password, {
    String? imoocId,
    String? orderId,
  }) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
    } else {
      request = LoginRequest();
    }
    request.add('userName', username).add('password', password);
    if (imoocId != null) {
      request.add('imoocId', imoocId);
    }
    if (orderId != null) {
      request.add('orderId', orderId);
    }

    var result = await HiNet.getInstance().fire(request);
    if (result['code'] == 0 && result['data'] != null) {
      // 保存登录令牌
      HiCache.getInstance().setString(BOADRDING_PASS, result['data']);
    }
    return result;
  }

  static getBoadingPass() {
    var pass = HiCache.getInstance().get(BOADRDING_PASS);
    if (pass == null) {
      return null;
    } else {
      return pass;
    }
  }
}
