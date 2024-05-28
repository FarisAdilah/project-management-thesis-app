import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class StaffListController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  RxList<UserDM> users = <UserDM>[].obs;
  RxString imageUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    _getUsersData();
    _getImage();
  }

  _getUsersData() async {
    var response = await _userRepository.getAllUser();
    if (response.isNotEmpty) {
      users.value = response;
      Helpers().writeLog("response: ${jsonEncode(users.first)}");
    } else {
      Helpers().showErrorSnackBar("Failed to get user data");
    }
  }

  _getImage() async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child("images/facebook-profile.jpg");
    String url = await ref.getDownloadURL();
    imageUrl.value = url;
  }
}
