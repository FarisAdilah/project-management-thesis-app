// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectDM _$ProjectDMFromJson(Map<String, dynamic> json) => ProjectDM()
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..description = json['description'] as String?
  ..status = json['status'] as String?
  ..startDate = json['startDate'] as String?
  ..endDate = json['endDate'] as String?
  ..clientId = json['clientId'] as String?
  ..vendorId =
      (json['vendorId'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..userId =
      (json['userId'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..clientName = json['clientName'] as String?
  ..pmId = json['pmId'] as String?;

Map<String, dynamic> _$ProjectDMToJson(ProjectDM instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'clientId': instance.clientId,
      'vendorId': instance.vendorId,
      'userId': instance.userId,
      'clientName': instance.clientName,
      'pmId': instance.pmId,
    };
