class ApiResult<T> {
  final T? data;
  final String? error;
  bool get isSuccess => error == null;
  ApiResult.sucess(this.data):error=null;
  ApiResult.failure(this.error):data=null;
}