import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TimelineFirebase {
  String? id;
  String? timelineName;
  String? startDate;
  String? endDate;
  List<String>? tasksId;

  TimelineFirebase();

  factory TimelineFirebase.fromFirestoreList(
    QueryDocumentSnapshot<Map<String, dynamic>> querySnapshot, {
    SnapshotOptions? options,
  }) {
    final data = querySnapshot.data();
    final timeline = TimelineFirebase()
      ..id = querySnapshot.id
      ..timelineName = data['timelineName']
      ..startDate = data['startDate']
      ..endDate = data['endDate']
      ..tasksId = List.from(data['taskId']);

    return timeline;
  }

  factory TimelineFirebase.fromFirestoreDoc(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final timeline = TimelineFirebase()
      ..id = snapshot.id
      ..timelineName = data?['timelineName']
      ..startDate = data?['startDate']
      ..endDate = data?['endDate']
      ..tasksId = List.from(data?['taskId']);

    return timeline;
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'timelineName': timelineName,
        'startDate': startDate,
        'endDate': endDate,
        'taskId': tasksId,
      };
}
