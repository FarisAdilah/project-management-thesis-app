import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleTaskFirebase {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  String? staffId;
  String? timelineId;
  String? status;

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
      ..staffId = data['staffId']
      ..timelineId = data['timelineId']
      ..status = data['status'];

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
      ..staffId = data['staffId']
      ..timelineId = data['timelineId']
      ..status = data['status'];

    return scheduleTask;
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'startDate': startDate,
        'endDate': endDate,
        'staffId': staffId,
        'timelineId': timelineId,
        'status': status,
      };
}
