import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/staff/mobile_select_staff.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/staff/tablet_select_staff.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/staff/web_select_staff.dart';
import 'package:project_management_thesis_app/pages/responsive_layout.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ProjectStaffController extends GetxController {
  RxInt selectedStaffIndex = (-1).obs;

  final List<UserDM> staffList;
  final Function(UserDM) onStaffSelected;

  ProjectStaffController({
    required this.staffList,
    required this.onStaffSelected,
  });

  selectStaff(int index) {
    if (index == selectedStaffIndex.value) {
      selectedStaffIndex.value = -1;
    } else {
      selectedStaffIndex.value = index;
    }
    Helpers.writeLog("selectedStaffIndex: $selectedStaffIndex");
  }

  addNewStaff() {
    Get.dialog(
      ResponsiveLayout(
        mobileScaffold: AlertDialog(
          backgroundColor: AssetColor.whiteBackground,
          contentPadding: const EdgeInsets.all(0),
          content: MobileSelectStaff(
            selectedStaffList: staffList,
            onStaffSelected: (staff) {
              onStaffSelected(staff);
            },
          ),
        ),
        tabletScaffold: AlertDialog(
          backgroundColor: AssetColor.whiteBackground,
          contentPadding: const EdgeInsets.all(0),
          content: TabletSelectStaff(
            selectedStaffList: staffList,
            onStaffSelected: (staff) {
              onStaffSelected(staff);
            },
          ),
        ),
        desktopScaffold: AlertDialog(
          backgroundColor: AssetColor.whiteBackground,
          contentPadding: const EdgeInsets.all(0),
          content: WebSelectStaff(
            selectedStaffList: staffList,
            onStaffSelected: (staff) {
              onStaffSelected(staff);
            },
          ),
        ),
      ),
    );
  }
}
