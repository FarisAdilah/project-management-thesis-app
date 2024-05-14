import 'package:json_annotation/json_annotation.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/dataModel/schedule_task_dm.dart';

part 'timeline_dm.g.dart';

@JsonSerializable()
class TimelineDM {
  String? id;
  String? timelineName;
  String? startDate;
  String? endDate;
  List<ScheduleTaskDM>? scheduleTask;

  TimelineDM();

  factory TimelineDM.fromJson(Map<String, dynamic> json) =>
      _$TimelineDMFromJson(json);

  Map<String, dynamic> toJson() => _$TimelineDMToJson(this);
}
