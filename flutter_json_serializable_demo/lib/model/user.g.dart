// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  name: json['name'] as String,
  age: (json['age'] as num).toInt(),
  email: json['email'] as String?,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  address: Address.fromJson(json['address'] as Map<String, dynamic>),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  createdAt: User._fromTimestamp((json['created_at'] as num).toInt()),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'name': instance.name,
  'age': instance.age,
  'email': instance.email,
  'role': _$UserRoleEnumMap[instance.role]!,
  'address': instance.address,
  'tags': instance.tags,
  'created_at': User._toTimestamp(instance.createdAt),
};

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.user: 'user',
  UserRole.guest: 'guest',
};
