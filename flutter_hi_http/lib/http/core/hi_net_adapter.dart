import 'dart:convert';

import 'package:flutter_hi_http/http/request/base_request.dart';


abstract class HiNetAdapter {
  Future<HiNetResponse<T>>send<T>(BaseRequest request);
}

class HiNetResponse<T> {
  HiNetResponse({
    this.data,
    this.request,
    this.statusCode,
    this.statusMessage,
    this.extra
  });

  final T? data;
  final BaseRequest? request;
  final int? statusCode;
  final String? statusMessage;
  final dynamic extra;

  @override
  String toString() {
    if(data is Map){
      return json.encode(data);
    }
    return data.toString();  
  }
}