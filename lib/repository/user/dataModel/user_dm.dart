import 'package:json_annotation/json_annotation.dart';

part 'user_dm.g.dart';

@JsonSerializable()
class UserDM {
  String? id;
  String? name;
  String? email;
  String? password;
  String? role;
  String? phoneNumber;
  String? image;

  UserDM();

  factory UserDM.fromJson(Map<String, dynamic> json) => _$UserDMFromJson(json);

  Map<String, dynamic> toJson() => _$UserDMToJson(this);
}
