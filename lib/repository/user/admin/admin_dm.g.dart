// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminDM _$AdminDMFromJson(Map<String, dynamic> json) => AdminDM()
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..email = json['email'] as String?
  ..password = json['password'] as String?
  ..role = json['role'] as String?
  ..phoneNumber = json['phoneNumber'] as String?
  ..image = json['image'] as String?;

Map<String, dynamic> _$AdminDMToJson(AdminDM instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
    };
