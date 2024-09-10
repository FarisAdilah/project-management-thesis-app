import 'package:json_annotation/json_annotation.dart';

part 'project_dm.g.dart';

@JsonSerializable()
class ProjectDM {
  String? id;
  String? name;
  String? description;
  String? status;
  String? startDate;
  String? endDate;
  String? clientId;
  List<String>? vendorId;
  List<String>? userId;
  String? clientName;
  String? pmId;
  String? file;
  String? fileName;

  ProjectDM();

  factory ProjectDM.fromJson(Map<String, dynamic> json) =>
      _$ProjectDMFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDMToJson(this);
}
