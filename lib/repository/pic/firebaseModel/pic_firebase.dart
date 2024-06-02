import 'package:cloud_firestore/cloud_firestore.dart';

class PicFirebase {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? role;

  PicFirebase();

  factory PicFirebase.fromFirestoreList(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    final pic = PicFirebase()
      ..id = snapshot.id
      ..name = data['name']
      ..email = data['email']
      ..phoneNumber = data['phoneNumber']
      ..role = data['role'];

    return pic;
  }

  factory PicFirebase.fromFirestoreDoc(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    final pic = PicFirebase()
      ..id = snapshot.id
      ..name = data?['name']
      ..email = data?['email']
      ..phoneNumber = data?['phoneNumber']
      ..role = data?['role'];

    return pic;
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }
}
