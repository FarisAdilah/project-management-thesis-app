import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/firebaseModel/user_firebase.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class ProfileController extends GetxController with Storage {
  final _userRepo = UserRepository.instance;

  Rx<UserDM> user = UserDM().obs;
  RxBool isLoading = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final roleController = TextEditingController();

  Rx<bool> isObscure = true.obs;
  Rx<bool> isEnabled = false.obs;

  @override
  void onInit() async {
    super.onInit();
    user.value = await getUserData() ?? UserDM();
    Helpers.writeLog("user: ${user.value.toJson()}");

    nameController.text = user.value.name ?? "";
    emailController.text = user.value.email ?? "";
    passwordController.text = user.value.password ?? "";
    phoneController.text = user.value.phoneNumber ?? "";
    roleController.text = Helpers().getUserRole(user.value.role ?? "");
  }

  toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  validateInput(String type, String value) {
    if (value.isEmpty) {
      isEnabled.value = false;
      return;
    }

    if (type == "password") {
      if (value != user.value.password) {
        isEnabled.value = true;
      } else {
        isEnabled.value = false;
      }
    } else {
      if (value != user.value.phoneNumber) {
        isEnabled.value = true;
      } else {
        isEnabled.value = false;
      }
    }
  }

  updateUserData() async {
    isLoading.value = true;

    UserFirebase param = UserFirebase();
    param.id = user.value.id;
    param.name = nameController.text;
    param.email = emailController.text;
    param.password = passwordController.text;
    param.phoneNumber = phoneController.text;
    param.role = user.value.role;
    param.image = user.value.image;
    param.projectId = user.value.projectId;

    Helpers.writeLog("param: ${param.toFirestore()}");

    bool isUpdated = await _userRepo.updateUser(
      param,
      user.value.name ?? "",
    );

    if (isUpdated) {
      Helpers.writeLog("isUpdated: $isUpdated");
      UserDM newUser = UserDM();
      newUser.id = param.id;
      newUser.email = param.email;
      newUser.name = param.name;
      newUser.password = param.password;
      newUser.phoneNumber = param.phoneNumber;
      newUser.role = param.role;
      newUser.image = param.image;
      newUser.projectId = param.projectId;

      await setUserData(newUser);

      isEnabled.value = false;
      user.value = newUser;
      Helpers().showSuccessSnackBar("Profile updated successfully");
    } else {
      Helpers().showErrorSnackBar("Something went wrong");
    }

    isLoading.value = false;
  }
}
