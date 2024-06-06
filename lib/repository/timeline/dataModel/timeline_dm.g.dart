// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineDM _$TimelineDMFromJson(Map<String, dynamic> json) => TimelineDM()
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..startDate = json['startDate'] as String?
  ..endDate = json['endDate'] as String?
  ..projectId = json['projectId'] as String?;

Map<String, dynamic> _$TimelineDMToJson(TimelineDM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'projectId': instance.projectId,
    };
