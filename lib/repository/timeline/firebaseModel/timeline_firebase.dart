import 'package:cloud_firestore/cloud_firestore.dart';

class TimelineFirebase {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  String? projectId;

  TimelineFirebase();

  factory TimelineFirebase.fromFirestoreList(
    QueryDocumentSnapshot<Map<String, dynamic>> querySnapshot, {
    SnapshotOptions? options,
  }) {
    final data = querySnapshot.data();
    final timeline = TimelineFirebase()
      ..id = querySnapshot.id
      ..name = data['name']
      ..startDate = data['startDate']
      ..endDate = data['endDate']
      ..projectId = data['projectId'];

    return timeline;
  }

  factory TimelineFirebase.fromFirestoreDoc(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final timeline = TimelineFirebase()
      ..id = snapshot.id
      ..name = data?['name']
      ..startDate = data?['startDate']
      ..endDate = data?['endDate']
      ..projectId = data?['projectId'];

    return timeline;
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'startDate': startDate,
        'endDate': endDate,
        'projectId': projectId,
      };
}
