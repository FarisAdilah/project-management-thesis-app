// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pic_firebase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PicFirebase _$PicFirebaseFromJson(Map<String, dynamic> json) => PicFirebase()
  ..name = json['name'] as String?
  ..email = json['email'] as String?
  ..phoneNumber = json['phoneNumber'] as String?
  ..role = json['role'] as String?;

Map<String, dynamic> _$PicFirebaseToJson(PicFirebase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
    };
