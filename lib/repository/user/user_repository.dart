import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/repository/authentication/authenticaton_repository.dart';
import 'package:project_management_thesis_app/repository/authentication/dataModel/login_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/firebaseModel/user_firebase.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class UserRepository with RepoBase {
  static UserRepository get instance => UserRepository();

  Future<bool> createUser(
    UserFirebase user,
    LoginDM currentUser, {
    File? pickedImage,
    Uint8List? pickedImageWeb,
  }) async {
    String url = "";

    if (user.email != null && user.password != null) {
      // Upload the image to the storage
      if (kIsWeb && (pickedImageWeb?.isNotEmpty ?? false)) {
        String username =
            user.name?.trim().toLowerCase().replaceAll(" ", "-") ?? "";
        url = await uploadFile(
          "images/$username",
          fileWeb: pickedImageWeb,
        );
      } else if (pickedImage?.path.isNotEmpty ?? false) {
        XFile image = XFile(pickedImage?.path ?? "");
        url = await uploadFile(
          "images",
          file: image,
        );
      }

      // Get the image url from the storage
      if (url.isNotEmpty) {
        user.image = url;
      } else {
        Helpers().showErrorSnackBar("Failed to upload image");
      }

      // Register the user with email and password
      bool isRegister =
          await registerWithEmailAndPassword(user.email!, user.password!);

      // Save the user data to the firestore
      if (isRegister) {
        await createData(
          CollectionType.users.name,
          user.toFirestore(),
          showPopup: false,
        );
      }

      UserDM? relog = await AuthenticationRepository().login(
        currentUser,
        showPopup: false,
      );

      if (relog != null) {
        return true;
      } else {
        return false;
      }
    } else {
      Helpers().showErrorSnackBar("Email and Password is not valid");
      return false;
    }
  }

  Future<bool> updateUser(
    UserFirebase user,
    String currUserName, {
    File? pickedImage,
    Uint8List? pickedImageWeb,
  }) async {
    String url = "";
    bool isDeleted = false;

    // Upload the image to the storage
    if (kIsWeb && (pickedImageWeb?.isNotEmpty ?? false)) {
      Helpers.writeLog("upload image web");
      String username = currUserName.trim().toLowerCase().replaceAll(" ", "-");

      isDeleted = await deleteFile("images/$username");

      if (isDeleted) {
        url = await uploadFile(
          "images/$username",
          fileWeb: pickedImageWeb,
        );
      } else {
        Helpers().showErrorSnackBar("Something went wrong");
        return false;
      }
    } else if (pickedImage?.path.isNotEmpty ?? false) {
      Helpers.writeLog("upload image mobile");
      XFile image = XFile(pickedImage?.path ?? "");

      String ref = await getRefFromUrl(user.image ?? "");
      isDeleted = await deleteFile("images/$ref");

      if (isDeleted) {
        url = await uploadFile(
          "images",
          file: image,
        );
      } else {
        Helpers().showErrorSnackBar("Something went wrong");
        return false;
      }
    } else {
      Helpers.writeLog("gambarnya sama nih");
      url = user.image ?? "";
    }

    // Get the image url from the storage
    if (url.isNotEmpty) {
      user.image = url;
    }

    // Update the user data to the firestore
    bool isUpdated = await updateData(
      CollectionType.users.name,
      user.id ?? "",
      user.toFirestore(),
    );

    Helpers.writeLog("isUpdated: $isUpdated");

    if (isUpdated) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteUser(UserDM user) async {
    String url = await getRefFromUrl(user.image ?? "");

    bool isDeleteImage;
    if (url.isNotEmpty) {
      isDeleteImage = await deleteFile("images/$url");
    } else {
      Helpers().showErrorSnackBar("Something went wrong");
      return false;
    }

    bool isDeleted = false;
    if (isDeleteImage) {
      isDeleted = await deleteData(CollectionType.users.name, user.id ?? "");
    }

    if (isDeleted) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<UserDM>> getAllUser() async {
    List collection = await getDataCollection(CollectionType.users.name);

    List<UserFirebase> userDataresponseList = [];
    for (var element in collection) {
      UserFirebase userDataResponse = UserFirebase.fromFirestoreList(element);
      userDataresponseList.add(userDataResponse);
    }

    List<UserDM> userList = [];
    for (var element in userDataresponseList) {
      UserDM user = UserDM();
      user.id = element.id;
      user.email = element.email;
      user.name = element.name;
      user.role = element.role;
      user.image = element.image;
      user.password = element.password;
      user.phoneNumber = element.phoneNumber;
      user.projectId = element.projectId;

      userList.add(user);
    }

    return userList;
  }

  Future<List<UserDM>> getMultipleUserByProject(String projectId) async {
    List collection = await getMultipleDocument(
      CollectionType.users.name,
      "projectId",
      projectId,
      isArray: true,
    );

    List<UserFirebase> userDataresponseList = [];
    for (var element in collection) {
      UserFirebase userDataResponse = UserFirebase.fromFirestoreList(element);
      userDataresponseList.add(userDataResponse);
    }

    List<UserDM> userList = [];
    for (var element in userDataresponseList) {
      UserDM user = UserDM();
      user.id = element.id;
      user.email = element.email;
      user.name = element.name;
      user.role = element.role;
      user.image = element.image;
      user.password = element.password;
      user.phoneNumber = element.phoneNumber;
      user.projectId = element.projectId;

      userList.add(user);
    }

    return userList;
  }

  Future<List<UserDM>> getMupltipleUserByRole(String role) async {
    List collection =
        await getMultipleDocument(CollectionType.users.name, "role", role);

    List<UserFirebase> userDataresponseList = [];
    for (var element in collection) {
      UserFirebase userDataResponse = UserFirebase.fromFirestoreList(element);
      userDataresponseList.add(userDataResponse);
    }

    List<UserDM> userList = [];
    for (var element in userDataresponseList) {
      UserDM user = UserDM();
      user.id = element.id;
      user.email = element.email;
      user.name = element.name;
      user.role = element.role;
      user.image = element.image;
      user.password = element.password;
      user.phoneNumber = element.phoneNumber;
      user.projectId = element.projectId;

      userList.add(user);
    }

    return userList;
  }

  Future<UserDM> getUserById(String id) async {
    var data = await getDataDocument(CollectionType.users.name, id);

    UserFirebase userFirebase = UserFirebase.fromFirestoreDoc(data);
    UserDM user = UserDM();
    user.id = userFirebase.id;
    user.email = userFirebase.email;
    user.name = userFirebase.name;
    user.role = userFirebase.role;
    user.image = userFirebase.image;
    user.password = userFirebase.password;
    user.phoneNumber = userFirebase.phoneNumber;
    user.projectId = userFirebase.projectId;

    return user;
  }

  Future<bool> addUserProjectId(String userId, String projectId) async {
    return updateData(
      CollectionType.users.name,
      userId,
      {
        "projectId": FieldValue.arrayUnion([projectId])
      },
    );
  }

  Future<bool> removeUserProjectId(String userId, String projectId) async {
    return updateData(
      CollectionType.users.name,
      userId,
      {
        "projectId": FieldValue.arrayRemove([projectId])
      },
    );
  }
}
