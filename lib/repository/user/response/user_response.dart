import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserDataResponse {
  String? id;
  String? name;
  String? email;
  String? password;
  String? role;
  String? phoneNumber;
  String? image;

  UserDataResponse();

  factory UserDataResponse.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final user = UserDataResponse()
      ..id = snapshot.id
      ..email = data['email']
      ..name = data['name']
      ..password = data['password']
      ..role = data['role']
      ..phoneNumber = data['phoneNumber']
      ..image = data['image'];

    return user;
  }

  Map<String, dynamic> toFirebase() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'role': role,
        'phoneNumber': phoneNumber,
        'image': image,
      };
}
