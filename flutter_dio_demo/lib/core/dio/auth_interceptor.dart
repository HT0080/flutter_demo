import 'dart:async';
import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

// 优化 多个并发请求除非401时可能重复刷新token
// 使用队列和异步锁确保仅一次刷新

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final _lock = Lock();
  final List<Completer<void>> _pendingRequests = [];
  bool _isRefreshing = false;
  late SharedPreferences _prefs;

  AuthInterceptor(this._dio) {
    SharedPreferences.getInstance().then((prefs) => _prefs = prefs);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 初始化请求头（例如添加基础Token）
    final accessToken = _prefs.getString('asscess_token');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // 将请求加入等待队列
      final completer = Completer<void>();
      _pendingRequests.add(completer);

      await _lock.synchronized(() async {
        if (!_isRefreshing) {
          _isRefreshing = true;
          try {
            final newToken = await _refreshToken();
            if (newToken != null) {
              await _prefs.setString('access_token', newToken);
              // 更新全局token
              _dio.options.headers['Authorization'] = 'Bearer $newToken';
              // 重新发送所有等待的请求
              _pendingRequests.forEach((c) => c.complete());
            } else {
              // Token刷新失败，通知所有请求失败
              _pendingRequests.forEach((c) => c.completeError('请重新登录'));
            }
          } catch (e) {
            _pendingRequests.forEach((c) => c.completeError(e));
          } finally {
            _pendingRequests.clear();
            _isRefreshing = false;
          }
        }
      });
    }
    try {
      final response = await _dio.fetch(err.requestOptions);
      handler.resolve(response);
    } catch (e) {
      handler.next(err);
    }
  }

  Future<String?> _refreshToken() async {
    final refreshToken = _prefs.getString('refresh_token');
    if (refreshToken == null) return null;
    // TODO 测试接口
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      return response.data['access_token'];
    } on DioException {
      return null;
    }
  }
}
