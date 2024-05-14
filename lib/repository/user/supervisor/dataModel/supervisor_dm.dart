import 'package:json_annotation/json_annotation.dart';
import 'package:project_management_thesis_app/repository/user/abstract/user_dm.dart';

part 'supervisor_dm.g.dart';

@JsonSerializable()
class SupervisorDM extends UserDM {
  SupervisorDM();

  factory SupervisorDM.fromJson(Map<String, dynamic> json) =>
      _$SupervisorDMFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SupervisorDMToJson(this);
}
