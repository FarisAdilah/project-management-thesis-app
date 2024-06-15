import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebase {
  String? id;
  String? name;
  String? email;
  String? password;
  String? role;
  String? phoneNumber;
  String? image;
  List<String>? projectId;

  UserFirebase();

  factory UserFirebase.fromFirestoreList(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final user = UserFirebase()
      ..id = snapshot.id
      ..email = data['email']
      ..name = data['name']
      ..password = data['password']
      ..role = data['role']
      ..phoneNumber = data['phoneNumber']
      ..image = data['image']
      ..projectId = List.from(data['projectId']);

    return user;
  }

  factory UserFirebase.fromFirestoreDoc(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final user = UserFirebase()
      ..id = snapshot.id
      ..email = data?['email']
      ..name = data?['name']
      ..password = data?['password']
      ..role = data?['role']
      ..phoneNumber = data?['phoneNumber']
      ..image = data?['image']
      ..projectId = List.from(data?['projectId']);

    return user;
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
        'phoneNumber': phoneNumber,
        'image': image,
        'projectId': projectId,
      };
}
