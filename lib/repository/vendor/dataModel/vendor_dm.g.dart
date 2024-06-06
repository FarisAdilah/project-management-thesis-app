// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorDM _$VendorDMFromJson(Map<String, dynamic> json) => VendorDM()
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..description = json['description'] as String?
  ..email = json['email'] as String?
  ..image = json['image'] as String?
  ..address = json['address'] as String?
  ..phoneNumber = json['phoneNumber'] as String?
  ..pic = json['pic'] == null
      ? null
      : PicDM.fromJson(json['pic'] as Map<String, dynamic>)
  ..projectId =
      (json['projectId'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$VendorDMToJson(VendorDM instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'email': instance.email,
      'image': instance.image,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'pic': instance.pic,
      'projectId': instance.projectId,
    };
