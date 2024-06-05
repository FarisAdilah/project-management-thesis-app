import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

mixin RepoBase {
  static FirebaseFirestore get _db => FirebaseFirestore.instance;
  static FirebaseAuth get _auth => FirebaseAuth.instance;
  static FirebaseStorage get _storage => FirebaseStorage.instance;

  // Base Repo for Repository Data Operation
  Future<bool> createData(
    String collection,
    Map<String, dynamic> data, {
    bool showPopup = false,
    String successMessage = "Your data has been created successfully!",
    String failedMessage = "Failed to create data",
  }) async {
    bool isCreated = false;
    await _db.collection(collection).add(data).whenComplete(() {
      isCreated = true;
      if (showPopup) {
        Helpers().showSuccessSnackBar(successMessage);
      }
    }).catchError((error) => showPopup
        ? Helpers().showErrorSnackBar(
            "$failedMessage: $error",
          )
        : ());

    return isCreated;
  }

  Future<bool> updateData(
    String collection,
    String id,
    Map<String, dynamic> data, {
    bool showPopup = false,
    String successMessage = "Your data has been updated successfully!",
    String failedMessage = "Failed to update data",
  }) async {
    bool isUpdated = false;
    await _db.collection(collection).doc(id).update(data).then(
      (value) {
        isUpdated = true;
        if (showPopup) {
          Helpers().showSuccessSnackBar(successMessage);
        }
      },
      onError: (error) {
        if (showPopup) {
          Helpers().showErrorSnackBar("$failedMessage: $error");
        }
      },
    );

    return isUpdated;
  }

  Future<bool> deleteData(
    String collection,
    String id, {
    bool showPopup = false,
    String successMessage = "Your data has been deleted successfully!",
    String failedMessage = "Failed to delete data",
  }) async {
    bool isDeleted = false;
    await _db.collection(collection).doc(id).delete().then(
      (value) {
        isDeleted = true;
        if (showPopup) {
          Helpers()
              .showSuccessSnackBar("Your data has been deleted successfully!");
        }
      },
      onError: (error) {
        Helpers().showErrorSnackBar("Failed to delete data: $error");
      },
    );
    return isDeleted;
  }

  getDataCollection(String collection, {String? orderBy}) async {
    var dataList = [];

    await _db.collection(collection).orderBy(orderBy ?? "name").get().then(
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

  getDataDocument(String collection, String id) async {
    return await _db.collection(collection).doc(id).get();
  }

  // Authentication Operation
  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      Helpers().showErrorSnackBar("Failed to register: $e");
      return false;
    }
  }

  // File Operation
  Future<String> uploadImage(
    String path, {
    XFile? image,
    Uint8List? imageWeb,
  }) async {
    final metadata = SettableMetadata(contentType: 'image/jpeg');
    try {
      if (kIsWeb && imageWeb != null) {
        final ref = _storage.ref().child(path);
        await ref.putData(imageWeb, metadata);
        final url = await ref.getDownloadURL();
        Helpers.writeLog("url: $url");
        return url;
      } else if (image != null) {
        final ref = _storage.ref(path).child(image.name);
        await ref.putFile(File(image.path), metadata);
        final url = await ref.getDownloadURL();
        Helpers.writeLog("url: $url");
        return url;
      } else {
        return "";
      }
    } on FirebaseException catch (e) {
      Helpers().showErrorSnackBar("Failed to upload file: $e");
      return "";
    }
  }

  Future<bool> deleteImage(String path) async {
    try {
      await _storage.ref().child(path).delete();
      return true;
    } on FirebaseException catch (e) {
      Helpers().showErrorSnackBar("Failed to delete file: $e");
      return false;
    }
  }

  Future<String> getImageRefFromUrl(String url) async {
    try {
      final ref = _storage.refFromURL(url).name;
      Helpers.writeLog("image ref: $ref");
      return ref;
    } on FirebaseException catch (e) {
      Helpers().showErrorSnackBar("Failed to get image ref: $e");
      return "";
    }
  }
}
