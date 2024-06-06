import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_management_thesis_app/repository/pic/firebaseModel/pic_firebase.dart';

class ClientFirebase {
  String? id;
  String? name;
  String? description;
  String? email;
  String? image;
  String? address;
  String? phoneNumber;
  PicFirebase? pic;
  List<String>? projectId;

  ClientFirebase();

  factory ClientFirebase.fromFirestoreList(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final client = ClientFirebase()
      ..id = snapshot.id
      ..name = data['name']
      ..description = data['description']
      ..email = data['email']
      ..image = data['image']
      ..address = data['address']
      ..phoneNumber = data['phoneNumber']
      ..pic = PicFirebase.fromJson(data['pic'])
      ..projectId = List.from(data['projectId']);

    return client;
  }

  factory ClientFirebase.fromFirestoreDoc(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final client = ClientFirebase()
      ..id = snapshot.id
      ..name = data?['name']
      ..description = data?['description']
      ..email = data?['email']
      ..image = data?['image']
      ..address = data?['address']
      ..phoneNumber = data?['phoneNumber']
      ..pic = PicFirebase.fromJson(data?['pic'])
      ..projectId = List.from(data?['projectId']);

    return client;
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'description': description,
        'email': email,
        'image': image,
        'address': address,
        'phoneNumber': phoneNumber,
        'pic': pic?.toJson(),
        'projectId': projectId,
      };
}
