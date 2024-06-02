import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientList/client_list.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/main_page.dart';
import 'package:project_management_thesis_app/pages/profilePage/profile.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffList/staff_list.dart';
import 'package:project_management_thesis_app/pages/vendorPage/vendorList/vendor_list.dart';
import 'package:project_management_thesis_app/pages/wrapper/controller_wrapper.dart';
import 'package:project_management_thesis_app/repository/authentication/authenticaton_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/menu_utility.dart';
import 'package:project_management_thesis_app/utils/model/menus.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class HomePageController extends GetxController with Storage {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  RxList<UserDM> users = <UserDM>[].obs;

  RxList<Menus> menus = <Menus>[].obs;
  RxInt selectedMenuId = 1.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    menus.value = MenuUtility().getAllMenu();
  }

  logout() async {
    isLoading.value = true;
    await _authenticationRepository.logout();
    await setUserData(UserDM());
    isLoading.value = false;
    Get.deleteAll();
    Get.put(WrapperController());
  }

  setSelectedMenu(Menus menu) {
    selectedMenuId.value = menu.id ?? 1;
  }

  Widget getSelectedMenuWidget() {
    Helpers.writeLog("selectedMenuId: ${selectedMenuId.value}");
    if (selectedMenuId.value == 1) {
      return const MainHomePage();
    } else if (selectedMenuId.value == 2) {
      return const StaffList();
    } else if (selectedMenuId.value == 3) {
      return const VendorList();
    } else if (selectedMenuId.value == 4) {
      return const ClientList();
    } else if (selectedMenuId.value == 5) {
      return const Profile();
    } else {
      return const Center(child: CustomText("Ini Halaman Untuk Data Lainnya"));
    }
  }
}
