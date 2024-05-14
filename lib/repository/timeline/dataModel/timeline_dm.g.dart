// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineDM _$TimelineDMFromJson(Map<String, dynamic> json) => TimelineDM()
  ..id = json['id'] as String?
  ..timelineName = json['timelineName'] as String?
  ..startDate = json['startDate'] as String?
  ..endDate = json['endDate'] as String?
  ..scheduleTask = (json['scheduleTask'] as List<dynamic>?)
      ?.map((e) => ScheduleTaskDM.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$TimelineDMToJson(TimelineDM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timelineName': instance.timelineName,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'scheduleTask': instance.scheduleTask,
    };
