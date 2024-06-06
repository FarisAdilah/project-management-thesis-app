import 'package:json_annotation/json_annotation.dart';

part 'schedule_task_dm.g.dart';

@JsonSerializable()
class ScheduleTaskDM {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  String? timelineId;
  String? staffId;

  ScheduleTaskDM();

  factory ScheduleTaskDM.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTaskDMFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleTaskDMToJson(this);
}
