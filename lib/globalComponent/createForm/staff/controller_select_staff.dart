import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class SelectStaffController extends GetxController {
  final UserRepository _userRepo = UserRepository.instance;

  RxBool isLoading = false.obs;
  Rx<UserDM> currentSelection = UserDM().obs;

  RxList<UserDM> staffs = <UserDM>[].obs;
  RxList<UserDM> staffsToShow = <UserDM>[].obs;

  UserDM? selectedStaff;
  List<UserDM> staffList;

  SelectStaffController({
    this.selectedStaff,
    required this.staffList,
  });

  @override
  void onInit() async {
    super.onInit();
    await getStaffs();
  }

  getStaffs() async {
    isLoading.value = true;
    var list = await _userRepo.getMupltipleUserByRole(
      UserType.staff.name,
    );

    if (list.isNotEmpty) {
      staffs.value = list;
      staffsToShow.value = staffs.where((staff) {
        return !staffList.any(
          (existingStaff) => existingStaff.name == staff.name,
        );
      }).toList();
      staffs.value = staffsToShow.toList();
    }

    isLoading.value = false;

    currentSelection.value =
        staffs.firstWhere((element) => element.name == selectedStaff?.name);
  }

  setStaffSelected(UserDM name) {
    currentSelection.value = name;
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
