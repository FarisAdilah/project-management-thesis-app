import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentFirebase {
  String? id;
  String? name;
  String? clientName;
  String? vendorName;
  String? amount;

  PaymentFirebase();

  factory PaymentFirebase.fromFirestoreList(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final payment = PaymentFirebase()
      ..id = snapshot.id
      ..name = data['name']
      ..clientName = data['clientName']
      ..vendorName = data['vendorName']
      ..amount = data['amount'];

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
      ..clientName = data['clientName']
      ..vendorName = data['vendorName']
      ..amount = data['amount'];

    return payment;
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'clientName': clientName,
        'vendorName': vendorName,
        'amount': amount,
      };
}
