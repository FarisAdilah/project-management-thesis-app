import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProjectFirebase {
  String? id;
  String? name;
  String? description;
  String? status;
  String? startDate;
  String? endDate;
  String? client;
  List<String>? vendor;
  List<String>? timeline;
  List<String>? payment;

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
      ..vendor = List.from(data['vendor'])
      ..timeline = List.from(data['timeline'])
      ..payment = List.from(data['payment']);

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
