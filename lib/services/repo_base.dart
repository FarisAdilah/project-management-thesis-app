import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

mixin RepoBase {
  static FirebaseFirestore get _db => FirebaseFirestore.instance;
  static FirebaseAuth get _auth => FirebaseAuth.instance;

  // Base Repo for Repository Data Operation
  createData(
    String collection,
    Map<String, dynamic> data, {
    bool showPopup = false,
    String successMessage = "Your data has been created successfully!",
    String failedMessage = "Failed to create data",
  }) async {
    await _db.collection(collection).add(data).whenComplete(() {
      if (showPopup) {
        Helpers().showSuccessSnackBar(successMessage);
      }
    }).catchError(
      (error) => showPopup
          ? Helpers().showErrorSnackBar(
              "$failedMessage: $error",
            )
          : (),
    );
  }

  updateData(String collection, String id, Map<String, dynamic> data) async {
    await _db.collection(collection).doc(id).update(data);
  }

  deleteData(String collection, String id) async {
    await _db.collection(collection).doc(id).delete();
  }

  getDataCollection(String collection) async {
    var dataList = [];

    await _db.collection(collection).get().then(
      (value) {
        for (var element in value.docs) {
          dataList.add(element);
        }
      },
      onError: (error) {
        Helpers().showErrorSnackBar("Failed to get data: $error");
      },
    );
    return dataList;
  }

  getDataDocument(String collection, String id) {
    return _db.collection(collection).doc(id).snapshots();
  }

  //Authentication Operation
  registerWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Helpers().showErrorSnackBar("Failed to register: $e");
    }
  }
}
