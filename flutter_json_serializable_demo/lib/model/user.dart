import 'package:flutter_json_serializable_demo/model/address.dart';
import 'package:flutter_json_serializable_demo/model/user_role.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  /*
  // 当JSON中未找到该值或者为null时，使用默认值
  @JsonKey(defaultValue: '张三')
  //当设置为true，生成的代码对应键存在但值为null时抛出DisallowedNullValueException
  @JsonKey(disallowNullValue: true)
// 提供一个自定义函数，将JSON值转换为Dart字段类型
  @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp)
//  控制是否在从 JSON 反序列化时包含该字段,需要明确指定某些字段是否参与反序列化。
  @JsonKey(includeFromJson: true)
  //决定在序列化时是否包含值为 null 的字段,控制输出 JSON 是否包含空值字段。默认值为 null，表示遵循类级别的默认行为。
// 如果 disallowNullValue 为 true，则此字段被视为 false。
  @JsonKey(includeIfNull: true)
//控制是否在序列化到 JSON 时包含该字段,需要明确指定某些字段是否参与序列化。
  @JsonKey(includeToJson: true)
//提供自定义逻辑来从 JSON 中读取值,当需要从多个键组合或通过复杂逻辑获取值时。
// @JsonKey(readValue: )
// 指定在反序列化时是否必须存在该键。确保某些字段在 JSON 中必须存在。 如果键不存在，会抛出 MissingRequiredKeysException。
@JsonKey(required: true)
//指定当 JSON 中的值不在枚举范围内时使用的默认值。
// @JsonKey(unknownEnumValue: enum)

  //指定 JSON 键与 Dart 字段之间的映射关系。当 JSON 键名与 Dart 字段名不一致时。如果为 null，则使用 Dart 字段名作为 JSON 键。
  // @JsonKey(name: 'user_name')
  */
  final String name;
  final int age;
  final String? email;
  final UserRole role;
  final Address address;
  final List<String> tags;
  @JsonKey(name: 'created_at', fromJson: _fromTimestamp, toJson: _toTimestamp)
  final DateTime createdAt;

    @JsonKey(includeFromJson: false,includeToJson: false)
    String? tempSession;

  User({required this.name, 
  required this.age, 
  this.email,
  required this.role,
  required this.address,
  required this.tags,
  required this.createdAt,
  this.tempSession,
  });

  // 时间转换
  static DateTime _fromTimestamp(int ts) =>
      DateTime.fromMillisecondsSinceEpoch(ts);
  static int _toTimestamp(DateTime time) => time.millisecondsSinceEpoch;

  // 生成的Factory 方法
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // 生成的toJson 方法
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
