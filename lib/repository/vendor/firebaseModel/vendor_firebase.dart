import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_management_thesis_app/repository/pic/firebaseModel/pic_firebase.dart';

class VendorFirebase {
  String? id;
  String? name;
  String? description;
  String? email;
  String? image;
  String? address;
  String? phoneNumber;
  PicFirebase? pic;

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
      ..email = data['email']
      ..image = data['image']
      ..address = data['address']
      ..phoneNumber = data['phoneNumber']
      ..pic = PicFirebase.fromJson(data['pic']);

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
      ..email = data?['email']
      ..image = data?['image']
      ..address = data?['address']
      ..phoneNumber = data?['phoneNumber']
      ..pic = PicFirebase.fromJson(data?['pic']);

    return vendor;
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
      };
}
