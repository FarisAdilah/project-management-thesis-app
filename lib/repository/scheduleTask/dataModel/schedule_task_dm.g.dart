// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_task_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleTaskDM _$ScheduleTaskDMFromJson(Map<String, dynamic> json) =>
    ScheduleTaskDM()
      ..id = json['id'] as String?
      ..name = json['name'] as String?
      ..startDate = json['startDate'] as String?
      ..endDate = json['endDate'] as String?
      ..timelineId = json['timelineId'] as String?
      ..staffId = json['staffId'] as String?;

Map<String, dynamic> _$ScheduleTaskDMToJson(ScheduleTaskDM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'timelineId': instance.timelineId,
      'staffId': instance.staffId,
    };
