import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientList/mobile_client_list.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientList/tablet_client_list.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientList/web_client_list.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/mobile_main_page.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/tablet_main_page.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/web_main_page.dart';
import 'package:project_management_thesis_app/pages/profilePage/profile.dart';
import 'package:project_management_thesis_app/pages/responsive_layout.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffList/mobile_staff_list.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffList/tablet_staff_list.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffList/web_staff_list.dart';
import 'package:project_management_thesis_app/pages/vendorPage/vendorList/mobile_vendor_list.dart';
import 'package:project_management_thesis_app/pages/vendorPage/vendorList/tablet_vendor_list.dart';
import 'package:project_management_thesis_app/pages/vendorPage/vendorList/web_vendor_list.dart';
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
      return const ResponsiveLayout(
        mobileScaffold: MobileMainPage(),
        tabletScaffold: TabletMainPage(),
        desktopScaffold: WebMainPage(),
      );
    } else if (selectedMenuId.value == 2) {
      return const ResponsiveLayout(
        mobileScaffold: MobileStaffList(),
        tabletScaffold: TabletStaffList(),
        desktopScaffold: WebStaffList(),
      );
    } else if (selectedMenuId.value == 3) {
      return const ResponsiveLayout(
        mobileScaffold: MobileVendorList(),
        tabletScaffold: TabletVendorList(),
        desktopScaffold: WebVendorList(),
      );
    } else if (selectedMenuId.value == 4) {
      return const ResponsiveLayout(
        mobileScaffold: MobileClientList(),
        tabletScaffold: TabletClientList(),
        desktopScaffold: WebClientList(),
      );
    } else if (selectedMenuId.value == 5) {
      return const Profile();
    } else {
      return const Center(child: CustomText("Ini Halaman Untuk Data Lainnya"));
    }
  }
}
