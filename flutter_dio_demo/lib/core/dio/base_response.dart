class BaseResponse<T> {
  final int code;
  final String message;
  final T? data;

  bool get isSuccess => code == 200;
  BaseResponse({required this.code, required this.message, this.data});
  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    return BaseResponse<T>(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
