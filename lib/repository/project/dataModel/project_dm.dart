import 'package:json_annotation/json_annotation.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/repository/timeline/dataModel/timeline_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';

part 'project_dm.g.dart';

@JsonSerializable()
class ProjectDM {
  String? id;
  String? name;
  String? description;
  String? status;
  String? startDate;
  String? endDate;
  ClientDM? client;
  List<VendorDM>? vendor;
  List<TimelineDM>? timeline;
  List<PaymentDM>? payment;

  ProjectDM();

  factory ProjectDM.fromJson(Map<String, dynamic> json) =>
      _$ProjectDMFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDMToJson(this);
}
