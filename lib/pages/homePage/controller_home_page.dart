import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/create_form.dart';
import 'package:project_management_thesis_app/repository/authentication/authenticaton_repository.dart';
import 'package:project_management_thesis_app/repository/authentication/dataModel/login_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class HomePageController extends GetxController {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final UserRepository _userRepository = UserRepository();
  RxList<UserDM> users = <UserDM>[].obs;
  UserDM currentUser = UserDM();

  @override
  void onInit() async {
    super.onInit();
    await getUsersData();
    await _getCurrentUser();
  }

  _getCurrentUser() async {
    var user = await _authenticationRepository.user.first;
    UserDM? userDM = user;
    Helpers().writeLog("userDM: ${jsonEncode(userDM?.email)}");
    currentUser = userDM ?? UserDM();
  }

  getUsersData() async {
    var response = await _userRepository.getAllUser();
    if (response.isNotEmpty) {
      users.value = response;
      Helpers().writeLog("response: ${jsonEncode(users.first)}");
    } else {
      Helpers().showErrorSnackBar("Failed to get user data");
    }
  }

  logout() async {
    await _authenticationRepository.logout();
    Get.offAllNamed("/");
  }

  showCreateForm() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(25),
        width: Get.context!.width,
        child: CreateForm(
          onSubmit: (user) {
            Helpers().writeLog("user: ${jsonEncode(user)}");
            _createUser(user);

            Get.back();
          },
        ),
      ),
      barrierColor: Colors.transparent,
      backgroundColor: Colors.amber[50],
    );
  }

  _createUser(UserDM user) async {
    UserDM signedUser =
        users.firstWhere((element) => element.email == currentUser.email);
    Helpers().writeLog("currentUser: ${jsonEncode(currentUser)}");

    LoginDM loginDM = LoginDM();
    loginDM.email = signedUser.email;
    loginDM.password = signedUser.password;

    await _userRepository.createUser(user, loginDM);
  }
}
