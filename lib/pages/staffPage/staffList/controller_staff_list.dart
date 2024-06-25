import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/responsive_layout.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffDetail/mobile_staff_detail.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffDetail/web_staff_detail.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffForm/mobile_staff_form.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffForm/tablet_staff_form.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffForm/web_staff_form.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class StaffListController extends GetxController with Storage {
  final _userRepository = UserRepository.instance;

  RxList<UserDM> users = <UserDM>[].obs;
  RxInt totalSupervisor = 0.obs;
  RxInt totalAdmin = 0.obs;
  RxInt totalProjectManager = 0.obs;
  RxInt totalStaff = 0.obs;

  RxString imageUrl = "".obs;
  RxBool isLoading = false.obs;

  RxBool isHoverStaff = false.obs;
  RxInt selectedIndexStaff = (-1).obs;

  UserDM? currentUser;

  @override
  void onInit() async {
    super.onInit();
    _getImage();
    currentUser = await getUserData();
    Helpers.writeLog("currentUser Staff Page: ${jsonEncode(currentUser)}");
    await _getUsersData();
  }

  _getUsersData() async {
    isLoading.value = true;
    var response = await _userRepository.getAllUser();
    if (response.isNotEmpty) {
      users.value = response;
      Helpers.writeLog("response: ${jsonEncode(users)}");

      totalSupervisor.value = users
          .where((element) => element.role == UserType.supervisor.name)
          .length;
      totalAdmin.value =
          users.where((element) => element.role == UserType.admin.name).length;
      totalProjectManager.value = users
          .where((element) => element.role == UserType.projectManager.name)
          .length;
      totalStaff.value =
          users.where((element) => element.role == UserType.staff.name).length;
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
    Get.to(
      () => const ResponsiveLayout(
        mobileScaffold: MobileStaffForm(),
        tabletScaffold: TabletStaffForm(),
        desktopScaffold: WebStaffForm(),
      ),
    )?.whenComplete(
      () => _getUsersData(),
    );
  }

  onUpdateUser() {
    _getUsersData();
  }

  onDeleteUser(UserDM user) {
    Get.dialog(
      AlertDialog(
        title: const CustomText(
          "Delete User",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AssetColor.greyBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 16,
        ),
        content: CustomText(
          "Are you sure you want to delete ${user.name}?",
          fontSize: 18,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 16,
        ),
        actions: [
          TextButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AssetColor.orangeButton,
              ),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const CustomText(
              "Cancel",
              color: AssetColor.whiteBackground,
            ),
          ),
          TextButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AssetColor.redButton,
              ),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
              ),
            ),
            onPressed: () {
              Get.back();
              _deleteUser(user);
            },
            child: const CustomText(
              "Delete",
              color: AssetColor.whiteBackground,
            ),
          ),
        ],
      ),
    );
  }

  _deleteUser(UserDM user) async {
    isLoading.value = true;
    bool isDeleted = await _userRepository.deleteUser(user);
    if (isDeleted) {
      Helpers().showSuccessSnackBar("User has been deleted successfully");
      _getUsersData();
    } else {
      Helpers().showErrorSnackBar("Failed to delete user");
    }
  }

  setHoverValue(bool value, int index) {
    Helpers.writeLog("value: $value, index: $index");
    isHoverStaff.value = value;
    selectedIndexStaff.value = index;
  }

  showUserDetail(UserDM user) {
    Get.dialog(
      ResponsiveLayout(
        mobileScaffold: AlertDialog(
          backgroundColor: AssetColor.greyBackground,
          contentPadding: const EdgeInsets.all(0),
          content: MobileStaffDetail(user: user),
        ),
        tabletScaffold: AlertDialog(
          backgroundColor: AssetColor.greyBackground,
          contentPadding: const EdgeInsets.all(0),
          content: WebStaffDetail(user: user),
        ),
        desktopScaffold: AlertDialog(
          backgroundColor: AssetColor.greyBackground,
          contentPadding: const EdgeInsets.all(0),
          content: WebStaffDetail(user: user),
        ),
      ),
    );
  }
}
