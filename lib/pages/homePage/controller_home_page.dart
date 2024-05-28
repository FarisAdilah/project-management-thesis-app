import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/create_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/main_home_page.dart';
import 'package:project_management_thesis_app/pages/homePage/component/staffPage/staff_list.dart';
import 'package:project_management_thesis_app/repository/authentication/authenticaton_repository.dart';
import 'package:project_management_thesis_app/repository/authentication/dataModel/login_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/menu_utility.dart';
import 'package:project_management_thesis_app/utils/model/menus.dart';

class HomePageController extends GetxController {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final UserRepository _userRepository = UserRepository();

  RxList<UserDM> users = <UserDM>[].obs;
  UserDM currentUser = UserDM();

  RxList<Menus> menus = <Menus>[].obs;
  RxInt selectedMenuId = 1.obs;

  @override
  void onInit() async {
    super.onInit();
    menus.value = MenuUtility().getAllMenu();
    await _getCurrentUser();
  }

  _getCurrentUser() async {
    var user = await _authenticationRepository.user.first;
    UserDM? userDM = user;
    Helpers().writeLog("userDM: ${jsonEncode(userDM?.email)}");
    currentUser = userDM ?? UserDM();
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

  setSelectedMenu(Menus menu) {
    selectedMenuId.value = menu.id ?? 1;
  }

  Widget getSelectedMenuWidget() {
    Helpers().writeLog("selectedMenuId: ${selectedMenuId.value}");
    if (selectedMenuId.value == 1) {
      return MainHomePage(users: users);
    } else if (selectedMenuId.value == 2) {
      return const StaffList();
    } else if (selectedMenuId.value == 3) {
      return const Center(child: Text("Ini Halaman Untuk Vendor"));
    } else if (selectedMenuId.value == 4) {
      return const Center(child: Text("Ini Halaman Untuk Client"));
    } else {
      return const Center(child: Text("Ini Halaman Untuk Data Lainnya"));
    }
  }
}
