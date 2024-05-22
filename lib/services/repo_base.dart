import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

mixin RepoBase {
  static FirebaseFirestore get _db => FirebaseFirestore.instance;

  // Base Repo for Repository Data Operation
  createData(
    String collection,
    Map<String, dynamic> data, {
    String successMessage = "Your data has been created successfully!",
    String failedMessage = "Failed to create data",
  }) async {
    await _db
        .collection(collection)
        .add(data)
        .whenComplete(
          () => Helpers().showSuccessSnackBar(
            successMessage,
          ),
        )
        .catchError(
          (error) => Helpers().showErrorSnackBar(
            "$failedMessage: $error",
          ),
        );
  }

  updateData(String collection, String id, Map<String, dynamic> data) async {
    await _db.collection(collection).doc(id).update(data);
  }

  deleteData(String collection, String id) async {
    await _db.collection(collection).doc(id).delete();
  }

  Stream<QuerySnapshot> streamDataCollection(String collection) {
    return _db.collection(collection).snapshots();
  }

  Stream<DocumentSnapshot> streamDataDocument(String collection, String id) {
    return _db.collection(collection).doc(id).snapshots();
  }
}
