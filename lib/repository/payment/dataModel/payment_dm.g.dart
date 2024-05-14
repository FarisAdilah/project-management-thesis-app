// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDM _$PaymentDMFromJson(Map<String, dynamic> json) => PaymentDM()
  ..id = json['id'] as String?
  ..paymentName = json['paymentName'] as String?
  ..clientName = json['clientName'] as String?
  ..vendorName = json['vendorName'] as String?
  ..paymentAmount = json['paymentAmount'] as String?;

Map<String, dynamic> _$PaymentDMToJson(PaymentDM instance) => <String, dynamic>{
      'id': instance.id,
      'paymentName': instance.paymentName,
      'clientName': instance.clientName,
      'vendorName': instance.vendorName,
      'paymentAmount': instance.paymentAmount,
    };
