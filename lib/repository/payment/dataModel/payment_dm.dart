import 'package:json_annotation/json_annotation.dart';

part 'payment_dm.g.dart';

@JsonSerializable()
class PaymentDM {
  String? id;
  String? paymentName;
  String? clientId;
  String? vendorId;
  String? paymentAmount;
  String? deadline;
  String? projectId;
  String? status;

  PaymentDM();

  factory PaymentDM.fromJson(Map<String, dynamic> json) =>
      _$PaymentDMFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDMToJson(this);
}
