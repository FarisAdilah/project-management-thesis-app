import 'package:json_annotation/json_annotation.dart';

part 'timeline_dm.g.dart';

@JsonSerializable()
class TimelineDM {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  String? projectId;

  TimelineDM();

  factory TimelineDM.fromJson(Map<String, dynamic> json) =>
      _$TimelineDMFromJson(json);

  Map<String, dynamic> toJson() => _$TimelineDMToJson(this);
}
