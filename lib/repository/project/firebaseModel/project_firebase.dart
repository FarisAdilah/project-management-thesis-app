import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectFirebase {
  String? id;
  String? name;
  String? description;
  String? status;
  String? startDate;
  String? endDate;
  String? clientId;
  List<String>? vendorId;
  List<String>? userId;

  ProjectFirebase();

  factory ProjectFirebase.fromFirestoreList(
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
      ..clientId = data['clientId']
      ..vendorId = List.from(data['vendorId'])
      ..userId = List.from(data['userId']);

    return project;
  }

  factory ProjectFirebase.fromFirestoreDoc(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final project = ProjectFirebase()
      ..id = snapshot.id
      ..name = data!['name']
      ..description = data['description']
      ..status = data['status']
      ..startDate = data['startDate']
      ..endDate = data['endDate']
      ..clientId = data['clientId']
      ..vendorId = List.from(data['vendorId'])
      ..userId = List.from(data['userId']);

    return project;
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'description': description,
        'status': status,
        'startDate': startDate,
        'endDate': endDate,
        'clientId': clientId,
        'vendorId': vendorId,
        'userId': userId,
      };
}
