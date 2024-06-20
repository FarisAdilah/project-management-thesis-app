import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';

class SelectStaffController extends GetxController {
  final UserRepository _userRepo = UserRepository.instance;

  RxBool isLoading = false.obs;
  Rx<UserDM> currentSelection = UserDM().obs;

  RxList<UserDM> staffs = <UserDM>[].obs;
  RxList<UserDM> staffsToShow = <UserDM>[].obs;

  UserDM? selectedStaff;
  List<UserDM> staffList;

  final String userRole;
  final bool isAlreadyExist;

  SelectStaffController({
    this.selectedStaff,
    required this.staffList,
    this.userRole = "staff",
    this.isAlreadyExist = true,
  });

  @override
  void onInit() async {
    super.onInit();
    await getStaffs();
  }

  getStaffs() async {
    isLoading.value = true;
    var list = await _userRepo.getMupltipleUserByRole(
      userRole,
    );

    if (list.isNotEmpty) {
      staffs.value = list;
      if (isAlreadyExist) {
        staffsToShow.value = staffs.where((staff) {
          return !staffList.any(
            (existingStaff) => existingStaff.name == staff.name,
          );
        }).toList();
        staffs.value = staffsToShow.toList();
      } else {
        staffsToShow.value = staffs.where((staff) {
          return staffList.any(
            (existingStaff) => existingStaff.name == staff.name,
          );
        }).toList();
      }
    }

    isLoading.value = false;

    currentSelection.value = staffs.firstWhereOrNull(
            (element) => element.name == selectedStaff?.name) ??
        UserDM();
  }

  setStaffSelected(UserDM user) {
    currentSelection.value = user;
  }

  searchStaff(String name) {
    if (name.isEmpty) {
      staffsToShow.value = staffs.toList();
    } else {
      staffsToShow.value = staffs.where((staff) {
        return staff.name?.toLowerCase().contains(name.toLowerCase()) ?? false;
      }).toList();
    }
  }
}
