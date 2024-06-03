import 'package:json_annotation/json_annotation.dart';

part 'pic_firebase.g.dart';

@JsonSerializable()
class PicFirebase {
  String? name;
  String? email;
  String? phoneNumber;
  String? role;

  PicFirebase();

  factory PicFirebase.fromJson(Map<String, dynamic> json) =>
      _$PicFirebaseFromJson(json);

  Map<String, dynamic> toJson() => _$PicFirebaseToJson(this);
}
