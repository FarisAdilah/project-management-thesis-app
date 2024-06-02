import 'dart:io';

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

  createUser(
    UserDM user,
    LoginDM currentUser, {
    File? pickedImage,
    Uint8List? pickedImageWeb,
  }) async {
    String url = "";

    if (user.email != null && user.password != null) {
      // Upload the image to the storage
      if (kIsWeb && pickedImageWeb != null) {
        String username =
            user.name?.trim().toLowerCase().replaceAll(" ", "-") ?? "";
        url = await uploadImage(
          "images/$username",
          imageWeb: pickedImageWeb,
        );
      } else if (pickedImage != null) {
        XFile image = XFile(pickedImage.path);
        url = await uploadImage(
          "images",
          image: image,
        );
      }

      // Get the image url from the storage
      if (url.isNotEmpty) {
        user.image = url;
      } else {
        Helpers().showErrorSnackBar("Failed to upload image");
      }

      // Register the user with email and password
      final result =
          await registerWithEmailAndPassword(user.email!, user.password!);
      Helpers.writeLog("result: $result");

      // Save the user data to the firestore
      await createData(CollectionType.users.name, user.toJson());

      AuthenticationRepository().login(currentUser);
    } else {
      Helpers().showErrorSnackBar("Email and Password is not valid");
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

    return user;
  }
}
