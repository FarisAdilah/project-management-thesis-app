// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDM _$PaymentDMFromJson(Map<String, dynamic> json) => PaymentDM()
  ..id = json['id'] as String?
  ..paymentName = json['paymentName'] as String?
  ..clientId = json['clientId'] as String?
  ..vendorId = json['vendorId'] as String?
  ..paymentAmount = json['paymentAmount'] as String?
  ..deadline = json['deadline'] as String?
  ..projectId = json['projectId'] as String?;

Map<String, dynamic> _$PaymentDMToJson(PaymentDM instance) => <String, dynamic>{
      'id': instance.id,
      'paymentName': instance.paymentName,
      'clientId': instance.clientId,
      'vendorId': instance.vendorId,
      'paymentAmount': instance.paymentAmount,
      'deadline': instance.deadline,
      'projectId': instance.projectId,
    };
