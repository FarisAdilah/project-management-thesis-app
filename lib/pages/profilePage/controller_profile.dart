import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class ProfileController extends GetxController with Storage {
  Rx<UserDM> user = UserDM().obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final roleController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    user.value = getUserData() ?? UserDM();

    nameController.text = user.value.name ?? "";
    emailController.text = user.value.email ?? "";
    passwordController.text = user.value.password ?? "";
    phoneController.text = user.value.phoneNumber ?? "";
    roleController.text = user.value.role ?? "";
  }
}
