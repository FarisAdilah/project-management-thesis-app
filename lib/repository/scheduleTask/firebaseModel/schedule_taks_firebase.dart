import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ScheduleTaskFirebase {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  String? staffId;

  ScheduleTaskFirebase();

  factory ScheduleTaskFirebase.fromFirestoreList(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final scheduleTask = ScheduleTaskFirebase()
      ..id = snapshot.id
      ..name = data['name']
      ..startDate = data['startDate']
      ..endDate = data['endDate']
      ..staffId = data['staffId'];

    return scheduleTask;
  }

  factory ScheduleTaskFirebase.fromFirestoreDoc(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final scheduleTask = ScheduleTaskFirebase()
      ..id = snapshot.id
      ..name = data!['name']
      ..startDate = data['startDate']
      ..endDate = data['endDate']
      ..staffId = data['staffId'];

    return scheduleTask;
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'startDate': startDate,
        'endDate': endDate,
        'staffId': staffId,
      };
}
