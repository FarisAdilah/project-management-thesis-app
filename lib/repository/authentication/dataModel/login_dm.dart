import 'package:json_annotation/json_annotation.dart';

part 'login_dm.g.dart';

@JsonSerializable()
class LoginDM {
  String? email;
  String? password;

  LoginDM();

  factory LoginDM.fromJson(Map<String, dynamic> json) =>
      _$LoginDMFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDMToJson(this);
}
