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
  ..client = (json['client'] as List<dynamic>?)
      ?.map((e) => ClientDM.fromJson(e as Map<String, dynamic>))
      .toList()
  ..vendor = (json['vendor'] as List<dynamic>?)
      ?.map((e) => VendorDM.fromJson(e as Map<String, dynamic>))
      .toList()
  ..timeline = (json['timeline'] as List<dynamic>?)
      ?.map((e) => TimelineDM.fromJson(e as Map<String, dynamic>))
      .toList()
  ..payment = (json['payment'] as List<dynamic>?)
      ?.map((e) => PaymentDM.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ProjectDMToJson(ProjectDM instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'client': instance.client,
      'vendor': instance.vendor,
      'timeline': instance.timeline,
      'payment': instance.payment,
    };
