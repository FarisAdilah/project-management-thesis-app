import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/repository/timeline/dataModel/timeline_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';

@JsonSerializable()
class ProjectFirebase {
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

  ProjectFirebase();

  factory ProjectFirebase.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final project = ProjectFirebase()
      ..id = snapshot.id
      ..name = data['name']
      ..description = data['description']
      ..status = data['status']
      ..startDate = data['startDate']
      ..endDate = data['endDate']
      ..client = data['client']
      ..vendor = data['vendor']
      ..timeline = data['timeline']
      ..payment = data['payment'];

    return project;
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'description': description,
        'status': status,
        'startDate': startDate,
        'endDate': endDate,
        'client': client,
        'vendor': vendor,
        'timeline': timeline,
        'payment': payment,
      };
}
