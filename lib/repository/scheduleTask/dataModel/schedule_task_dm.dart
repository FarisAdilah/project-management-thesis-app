import 'package:json_annotation/json_annotation.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';

part 'schedule_task_dm.g.dart';

@JsonSerializable()
class ScheduleTaskDM {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  UserDM? staff;

  ScheduleTaskDM();

  factory ScheduleTaskDM.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTaskDMFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleTaskDMToJson(this);
}
