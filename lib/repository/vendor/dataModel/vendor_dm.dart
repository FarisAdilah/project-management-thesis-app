import 'package:json_annotation/json_annotation.dart';

part 'vendor_dm.g.dart';

@JsonSerializable()
class VendorDM {
  String? id;
  String? name;
  String? description;
  String? image;
  String? address;
  String? phoneNumber;
  List<String>? pic;

  VendorDM();

  factory VendorDM.fromJson(Map<String, dynamic> json) =>
      _$VendorDMFromJson(json);

  Map<String, dynamic> toJson() => _$VendorDMToJson(this);
}
