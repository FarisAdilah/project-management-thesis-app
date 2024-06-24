import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class ProfileController extends GetxController with Storage {
  Rx<UserDM> user = UserDM().obs;

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
}
