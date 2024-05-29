import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ClientFirebase {
  String? id;
  String? name;
  String? description;
  String? image;
  String? address;
  String? phoneNumber;
  List<String>? pic;

  ClientFirebase();

  factory ClientFirebase.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final client = ClientFirebase()
      ..id = snapshot.id
      ..name = data['name']
      ..description = data['description']
      ..image = data['image']
      ..address = data['address']
      ..phoneNumber = data['phoneNumber']
      ..pic = data['pic'];

    return client;
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'address': address,
        'phoneNumber': phoneNumber,
        'pic': pic,
      };
}
