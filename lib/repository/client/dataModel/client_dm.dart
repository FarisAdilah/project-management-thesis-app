import 'package:json_annotation/json_annotation.dart';
import 'package:project_management_thesis_app/repository/pic/dataModel/pic_dm.dart';

part 'client_dm.g.dart';

@JsonSerializable()
class ClientDM {
  String? id;
  String? name;
  String? description;
  String? email;
  String? image;
  String? address;
  String? phoneNumber;
  PicDM? pic;

  ClientDM();

  factory ClientDM.fromJson(Map<String, dynamic> json) =>
      _$ClientDMFromJson(json);

  Map<String, dynamic> toJson() => _$ClientDMToJson(this);
}
