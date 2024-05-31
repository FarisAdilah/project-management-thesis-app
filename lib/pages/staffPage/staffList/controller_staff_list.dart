import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffAdd/staff_add.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class StaffListController extends GetxController {
  final _userRepository = UserRepository.instance;

  RxList<UserDM> users = <UserDM>[].obs;

  RxString imageUrl = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _getImage();
    await _getUsersData();
  }

  _getUsersData() async {
    isLoading.value = true;
    var response = await _userRepository.getAllUser();
    if (response.isNotEmpty) {
      users.value = response;
      Helpers.writeLog("response: ${jsonEncode(users)}");
    } else {
      Helpers().showErrorSnackBar("Failed to get user data");
    }
    isLoading.value = false;
  }

  _getImage() async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child("images/facebook-profile.jpg");
    String url = await ref.getDownloadURL();
    imageUrl.value = url;
  }

  showCreateForm(BuildContext context) {
    Get.to(() => const StaffAdd())?.whenComplete(() => _getUsersData());
  }
}
