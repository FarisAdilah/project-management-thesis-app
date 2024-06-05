import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/repository/authentication/dataModel/login_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/firebaseModel/user_firebase.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class StaffFormController extends GetxController with Storage {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final roleController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final imageController = TextEditingController();

  final UserDM? userToUpdate;

  StaffFormController({
    this.userToUpdate,
  });

  final ImagePicker _picker = ImagePicker();
  Rx<File> pickedImage = File("").obs;
  Rx<Uint8List> pickedImageWeb = Uint8List(0).obs;

  RxBool isLoading = false.obs;

  List role = [
    "Supervisor",
    "Admin",
    "Project Manager",
    "Staff",
  ];

  @override
  void onInit() {
    super.onInit();

    if (userToUpdate != null) {
      nameController.text = userToUpdate?.name ?? "";
      emailController.text = userToUpdate?.email ?? "";
      roleController.text = Helpers().getUserRole(userToUpdate?.role ?? "");
      phoneNumberController.text = userToUpdate?.phoneNumber ?? "";
      imageController.text = userToUpdate?.image ?? "";
    }
  }

  Future<void> onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    XFile? pickedFile = await _picker.pickImage(source: source);

    isLoading.value = true;

    if (pickedFile != null) {
      if (kIsWeb) {
        Helpers.writeLog("helloooo kIsWeb: $kIsWeb");
        var image = await pickedFile.readAsBytes();
        pickedImageWeb.value = image;
      } else {
        var image = File(pickedFile.path);
        pickedImage.value = image;
      }
      Helpers.writeLog("pickedFile: ${pickedFile.path}");
      Helpers.writeLog("pickedImage: ${pickedImage.value}");
      Helpers.writeLog("pickedImageWeb: ${pickedImageWeb.value}");
    } else {
      Helpers.writeLog("No image selected.");
    }

    isLoading.value = false;
  }

  createUser() async {
    isLoading.value = true;

    UserFirebase user = UserFirebase();
    user.name = nameController.text;
    user.email = emailController.text;
    user.role = _getUserRole(roleController.text);
    user.phoneNumber = phoneNumberController.text;
    user.image = imageController.text;
    user.password = Helpers().getGeneratedPassword(
      nameController.text,
    );

    Helpers.writeLog("password: ${user.password}");

    UserDM? signedUser = await getUserData();
    if (signedUser == null) {
      Helpers().showErrorSnackBar("Something Wrong");
    } else {
      Helpers.writeLog("currentUser: ${jsonEncode(signedUser)}");

      LoginDM loginDM = LoginDM();
      loginDM.email = signedUser.email;
      loginDM.password = signedUser.password;

      bool isSuccess = await UserRepository().createUser(
        user,
        loginDM,
        pickedImage: pickedImage.value,
        pickedImageWeb: pickedImageWeb.value,
      );

      Helpers.writeLog("isSuccess: $isSuccess");

      if (isSuccess) {
        Get.back();
        Helpers.writeLog("User created successfully");
        await Helpers().showSuccessSnackBar("User created successfully");
      } else {
        Helpers().showErrorSnackBar("Failed to create user");
      }
    }

    isLoading.value = false;
  }

  String _getUserRole(String role) {
    if (role == "Supervisor") {
      return UserType.supervisor.name;
    } else if (role == "Admin") {
      return UserType.admin.name;
    } else if (role == "Project Manager") {
      return UserType.projectManager.name;
    } else if (role == "Staff") {
      return UserType.staff.name;
    } else {
      return UserType.staff.name;
    }
  }

  updateUser() async {
    isLoading.value = true;

    UserFirebase user = UserFirebase();
    user.id = userToUpdate?.id;
    user.password = userToUpdate?.password;
    user.name = nameController.text;
    user.email = emailController.text;
    user.role = _getUserRole(roleController.text);
    user.phoneNumber = phoneNumberController.text;
    user.image = userToUpdate?.image;

    bool isSuccess = await UserRepository().updateUser(
      user,
      userToUpdate?.name ?? "",
      pickedImage: pickedImage.value,
      pickedImageWeb: pickedImageWeb.value,
    );

    Helpers.writeLog("isSuccess: $isSuccess");

    if (isSuccess) {
      Get.back();
      Helpers.writeLog("User updated successfully");
      await Helpers().showSuccessSnackBar("User updated successfully");
    } else {
      Helpers().showErrorSnackBar("Failed to update user");
    }

    isLoading.value = false;
  }
}
