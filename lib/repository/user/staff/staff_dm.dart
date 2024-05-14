import 'package:json_annotation/json_annotation.dart';
import 'package:project_management_thesis_app/repository/user/abstract/user_dm.dart';

part 'staff_dm.g.dart';

@JsonSerializable()
class StaffDM extends UserDM {
  StaffDM();

  factory StaffDM.fromJson(Map<String, dynamic> json) =>
      _$StaffDMFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StaffDMToJson(this);
}
