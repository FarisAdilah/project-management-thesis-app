import 'package:json_annotation/json_annotation.dart';

part 'payment_dm.g.dart';

@JsonSerializable()
class PaymentDM {
  String? id;
  String? paymentName;
  String? clientName;
  String? vendorName;
  String? paymentAmount;

  PaymentDM();

  factory PaymentDM.fromJson(Map<String, dynamic> json) =>
      _$PaymentDMFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDMToJson(this);
}
