// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDM _$UserDMFromJson(Map<String, dynamic> json) => UserDM()
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..email = json['email'] as String?
  ..password = json['password'] as String?
  ..role = json['role'] as String?
  ..phoneNumber = json['phoneNumber'] as String?
  ..image = json['image'] as String?;

Map<String, dynamic> _$UserDMToJson(UserDM instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
    };
