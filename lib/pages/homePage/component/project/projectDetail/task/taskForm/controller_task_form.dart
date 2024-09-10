import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/staff/web_select_staff.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/dataModel/schedule_task_dm.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/firebaseModel/schedule_taks_firebase.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/schedule_task_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class TaskFormController extends GetxController {
  final _taskRepo = ScheduleTaskRepository.instance;

  RxBool isLoading = false.obs;

  final String timelineId;
  final bool isEdit;
  ScheduleTaskDM? task;

  TextEditingController nameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController staffController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  Rx<UserDM> chosenStaff = UserDM().obs;
  final List<UserDM> projectStaff;

  TaskFormController({
    required this.timelineId,
    required this.projectStaff,
    this.isEdit = false,
    this.task,
  });

  @override
  void onInit() {
    super.onInit();

    if (isEdit) {
      nameController.text = task!.name ?? "";
      startDate = DateTime.tryParse(task!.startDate ?? "");
      startDateController.text =
          Helpers().convertDateStringFormat(task!.startDate ?? "");
      endDate = DateTime.tryParse(task!.endDate ?? "");
      endDateController.text =
          Helpers().convertDateStringFormat(task!.endDate ?? "");
      chosenStaff.value = projectStaff.firstWhere(
        (element) => element.id == task!.staffId,
        orElse: () => UserDM(),
      );
      staffController.text = chosenStaff.value.name ?? "";
    }
  }

  selectDatePicker(
    BuildContext context,
    TextEditingController dateController,
  ) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: dateController == startDateController ? startDate : endDate,
      firstDate: startDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      dateController.text =
          Helpers().convertDateStringFormat(selectedDate.toString());
      if (dateController == startDateController) {
        startDate = selectedDate;
        endDate = null;
        endDateController.text = "";
      } else {
        endDate = selectedDate;
      }
    }
  }

  selectStaff() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AssetColor.whiteBackground,
        content: WebSelectStaff(
          initialStaff: chosenStaff.value,
          userRole: UserType.staff.name,
          selectedStaffList: projectStaff,
          onStaffSelected: (staff) {
            chosenStaff.value = staff;
            staffController.text = staff.name ?? "";
          },
          isAlreadyExist: false,
          title: "Select Project Staff",
          searchHint: "Search Project Staff",
          textButton: "Select",
        ),
      ),
    );
  }

  updateTask() async {
    isLoading.value = true;

    ScheduleTaskFirebase param = ScheduleTaskFirebase();
    param.id = task!.id;
    param.endDate = endDate.toString();
    param.name = nameController.text;
    param.staffId = chosenStaff.value.id;
    param.startDate = startDate.toString();
    param.timelineId = timelineId;
    param.status = task!.status;

    bool isUpdated = await _taskRepo.updateTask(param);

    if (isUpdated) {
      Get.back(result: true);
    } else {
      Helpers().showErrorSnackBar(
        "Failed to update task, please try again",
      );
    }
  }

  createTask() async {
    isLoading.value = true;

    ScheduleTaskFirebase param = ScheduleTaskFirebase();
    param.endDate = endDate.toString();
    param.name = nameController.text;
    param.staffId = chosenStaff.value.id;
    param.startDate = startDate.toString();
    param.timelineId = timelineId;
    param.status = TaskStatusType.notStarted.name;

    String taskId = await _taskRepo.createTask(param);

    if (taskId.isNotEmpty) {
      Get.back(result: true);
    } else {
      Helpers().showErrorSnackBar(
        "Failed to create task, please try again",
      );
    }

    isLoading.value = false;
  }
}
