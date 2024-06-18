import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/staff/select_staff.dart';
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
      AlertDialog(
        backgroundColor: AssetColor.whiteBackground,
        content: SelectStaff(
          selectedStaffList: staffList,
          onStaffSelected: (staff) {
            onStaffSelected(staff);
          },
        ),
      ),
    );
  }

  removeStaff() {
    // TODO: logic to remove staff from project
    Helpers().showErrorSnackBar("remove staff (not implemented yet)");
  }
}
