import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentFirebase {
  String? id;
  String? name;
  String? clientId;
  String? vendorId;
  String? amount;
  String? deadline;
  String? projectId;
  String? status;
  String? file;

  PaymentFirebase();

  factory PaymentFirebase.fromFirestoreList(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final payment = PaymentFirebase()
      ..id = snapshot.id
      ..name = data['name']
      ..clientId = data['clientId']
      ..vendorId = data['vendorId']
      ..amount = data['amount']
      ..deadline = data['deadline']
      ..projectId = data['projectId']
      ..status = data['status']
      ..file = data['file'];

    return payment;
  }

  factory PaymentFirebase.fromFirestoreDoc(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final payment = PaymentFirebase()
      ..id = snapshot.id
      ..name = data!['name']
      ..clientId = data['clientId']
      ..vendorId = data['vendorId']
      ..amount = data['amount']
      ..deadline = data['deadline']
      ..projectId = data['projectId']
      ..status = data['status']
      ..file = data['file'];

    return payment;
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'clientId': clientId,
        'vendorId': vendorId,
        'amount': amount,
        'deadline': deadline,
        'projectId': projectId,
        'status': status,
        'file': file,
      };
}
