import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class VendorFirebase {
  String? id;
  String? name;
  String? description;
  String? image;
  String? address;
  String? phoneNumber;
  List<String>? pic;

  VendorFirebase();

  factory VendorFirebase.fromFirestoreList(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final vendor = VendorFirebase()
      ..id = snapshot.id
      ..name = data['name']
      ..description = data['description']
      ..image = data['image']
      ..address = data['address']
      ..phoneNumber = data['phoneNumber']
      ..pic = List.from(data['pic']);

    return vendor;
  }

  factory VendorFirebase.fromFirestoreDoc(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final vendor = VendorFirebase()
      ..id = snapshot.id
      ..name = data?['name']
      ..description = data?['description']
      ..image = data?['image']
      ..address = data?['address']
      ..phoneNumber = data?['phoneNumber']
      ..pic = List.from(data?['pic']);

    return vendor;
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
