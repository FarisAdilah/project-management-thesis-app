import 'package:json_annotation/json_annotation.dart';
import 'package:project_management_thesis_app/repository/pic/dataModel/pic_dm.dart';

part 'vendor_dm.g.dart';

@JsonSerializable()
class VendorDM {
  String? id;
  String? name;
  String? description;
  String? image;
  String? address;
  String? phoneNumber;
  List<PicDM>? pic;

  VendorDM();

  factory VendorDM.fromJson(Map<String, dynamic> json) =>
      _$VendorDMFromJson(json);

  Map<String, dynamic> toJson() => _$VendorDMToJson(this);
}
