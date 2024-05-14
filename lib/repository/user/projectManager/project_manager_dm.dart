import 'package:json_annotation/json_annotation.dart';
import 'package:project_management_thesis_app/repository/user/abstract/user_dm.dart';

part 'project_manager_dm.g.dart';

@JsonSerializable()
class ProjectManagerDM extends UserDM {
  ProjectManagerDM();

  factory ProjectManagerDM.fromJson(Map<String, dynamic> json) =>
      _$ProjectManagerDMFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProjectManagerDMToJson(this);
}
