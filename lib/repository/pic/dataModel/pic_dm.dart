import 'package:json_annotation/json_annotation.dart';

part 'pic_dm.g.dart';

@JsonSerializable()
class PicDM {
  String? name;
  String? email;
  String? phoneNumber;
  String? role;

  PicDM();

  factory PicDM.fromJson(Map<String, dynamic> json) => _$PicDMFromJson(json);

  Map<String, dynamic> toJson() => _$PicDMToJson(this);
}
