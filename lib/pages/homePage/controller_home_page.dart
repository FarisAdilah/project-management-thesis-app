import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/main_home_page.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffAdd/staff_add.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffList/staff_list.dart';
import 'package:project_management_thesis_app/pages/vendorPage/vendorList/vendor_list.dart';
import 'package:project_management_thesis_app/repository/authentication/authenticaton_repository.dart';
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
    await _getUsersData();
  }

  _getCurrentUser() async {
    var user = await _authenticationRepository.user.first;
    UserDM? userDM = user;
    Helpers.writeLog("userDM: ${jsonEncode(userDM)}");
    currentUser = userDM ?? UserDM();
  }

  _getUsersData() async {
    var response = await _userRepository.getAllUser();
    if (response.isNotEmpty) {
      users.value = response;
      Helpers.writeLog("response: ${jsonEncode(users.first)}");
    } else {
      Helpers().showErrorSnackBar("Failed to get user data");
    }
  }

  logout() async {
    await _authenticationRepository.logout();
    Get.offAllNamed("/");
  }

  showCreateForm(BuildContext context) {
    Get.to(() => const StaffAdd())?.whenComplete(_getUsersData());
  }

  setSelectedMenu(Menus menu) {
    selectedMenuId.value = menu.id ?? 1;
  }

  Widget getSelectedMenuWidget() {
    Helpers.writeLog("selectedMenuId: ${selectedMenuId.value}");
    if (selectedMenuId.value == 1) {
      return const MainHomePage();
    } else if (selectedMenuId.value == 2) {
      return StaffList(users: users);
    } else if (selectedMenuId.value == 3) {
      return const VendorList();
    } else if (selectedMenuId.value == 4) {
      return const Center(child: Text("Ini Halaman Untuk Client"));
    } else {
      return const Center(child: Text("Ini Halaman Untuk Data Lainnya"));
    }
  }
}
