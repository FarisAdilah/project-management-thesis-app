import 'package:json_annotation/json_annotation.dart';
import 'package:project_management_thesis_app/repository/user/abstract/user_dm.dart';

part 'admin_dm.g.dart';

@JsonSerializable()
class AdminDM extends UserDM {
  AdminDM();

  factory AdminDM.fromJson(Map<String, dynamic> json) =>
      _$AdminDMFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminDMToJson(this);
}
