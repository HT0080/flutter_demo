// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
  (json['code'] as num).toInt(),
  json['method'] as String,
  json['requestPrams'] as String,
);

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
  'code': instance.code,
  'method': instance.method,
  'requestPrams': instance.requestPrams,
};
