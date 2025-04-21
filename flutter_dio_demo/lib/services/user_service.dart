import 'package:dio/dio.dart';
import 'package:flutter_dio_demo/core/dio/api_client.dart';
import 'package:flutter_dio_demo/core/dio/api_result.dart';
import 'package:flutter_dio_demo/core/dio/http_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserService {
  final ApiClient _api;
  UserService(this._api);
  Future<ApiResult<Map<String, dynamic>>> getUserInfo(CancelToken cancelToken) async{
    final response = await _api.request<Map<String, dynamic>>('/user/info',method:HttpMethod.get,cancelToken: cancelToken);
    if(response.isSuccess){
      return ApiResult.sucess(response.data);
    }
    return ApiResult.failure(response.message);
  }
}

final userServiceProvider = Provider<UserService>((ref){
  final apiClient = ref.watch(apiClientProvider);
  return UserService(apiClient);
});


// 使用示例
/**
 final userInfoProvider = FutureProvider.autoDispose((ref) async {
  final service = ref.read(userServiceProvider);
  final result = await service.getUserInfo();
  return result;
});
 */

/*
  // Widget
  ref.watch(userInfoProvider).when(
  data: (result) => result.isSuccess
      ? Text('Hello ${result.data!['name']}')
      : Text('Error: ${result.error}'),
  loading: () => CircularProgressIndicator(),
  error: (e, _) => Text('Error: $e'),
);

 */

/*
  使用示例含取消 
  final userInfoProvider = FutureProvider.autoDispose((ref) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());

  final service = ref.read(userServiceProvider);
  final result = await service.getUserInfo(cancelToken);
  return result;
});

widget 
ref.watch(userInfoProvider).when(
  data: (result) => result.isSuccess
      ? Text('Hello ${result.data!['name']}')
      : Text('Error: ${result.error}'),
  loading: () => CircularProgressIndicator(),
  error: (e, _) => Text('Error: $e'),
);

 */