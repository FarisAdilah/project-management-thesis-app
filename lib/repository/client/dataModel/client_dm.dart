import 'package:json_annotation/json_annotation.dart';

part 'client_dm.g.dart';

@JsonSerializable()
class ClientDM {
  String? id;
  String? name;
  String? description;
  String? image;
  String? address;
  String? phoneNumber;
  List<String>? pic;

  ClientDM();

  factory ClientDM.fromJson(Map<String, dynamic> json) =>
      _$ClientDMFromJson(json);

  Map<String, dynamic> toJson() => _$ClientDMToJson(this);
}
