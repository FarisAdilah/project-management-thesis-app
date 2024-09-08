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
  Future<String> createData(
    String collection,
    Map<String, dynamic> data, {
    bool showPopup = false,
    String successMessage = "Your data has been created successfully!",
    String failedMessage = "Failed to create data",
  }) async {
    String id = "";
    await _db.collection(collection).add(data).then((value) {
      id = value.id;
      if (showPopup) {
        Helpers().showSuccessSnackBar(successMessage);
      }
    }).catchError((error) => showPopup
        ? Helpers().showErrorSnackBar(
            "$failedMessage: $error",
          )
        : ());

    return id;
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

  getMultipleDocument(String collection, String field, String id,
      {bool isArray = false}) async {
    var datalist = [];

    if (isArray) {
      await _db
          .collection(collection)
          .where(field, arrayContains: id)
          .get()
          .then(
        (value) {
          for (var element in value.docs) {
            datalist.add(element);
          }
        },
        onError: (error) {
          Helpers().showErrorSnackBar("Failed to get data: $error");
        },
      );
    } else {
      await _db.collection(collection).where(field, isEqualTo: id).get().then(
        (value) {
          for (var element in value.docs) {
            datalist.add(element);
          }
        },
        onError: (error) {
          Helpers().showErrorSnackBar("Failed to get data: $error");
        },
      );
    }

    return datalist;
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
  Future<String> uploadFile(
    String path, {
    XFile? file,
    Uint8List? fileWeb,
    String? contentType,
  }) async {
    final metadata = SettableMetadata(contentType: contentType ?? 'image/jpeg');
    try {
      if (kIsWeb && fileWeb != null) {
        final ref = _storage.ref().child(path);
        await ref.putData(fileWeb, metadata);
        final url = await ref.getDownloadURL();
        Helpers.writeLog("url: $url");
        return url;
      } else if (file != null) {
        final ref = _storage.ref(path).child(file.name);
        await ref.putFile(File(file.path), metadata);
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

  Future<bool> deleteFile(String path) async {
    try {
      await _storage.ref().child(path).delete();
      return true;
    } on FirebaseException catch (e) {
      Helpers().showErrorSnackBar("Failed to delete file: $e");
      return false;
    }
  }

  Future<String> getRefFromUrl(String url) async {
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
