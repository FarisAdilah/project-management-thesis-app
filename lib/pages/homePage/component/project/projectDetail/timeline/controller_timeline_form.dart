import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/timeline/dataModel/timeline_dm.dart';
import 'package:project_management_thesis_app/repository/timeline/firebaseModel/timeline_firebase.dart';
import 'package:project_management_thesis_app/repository/timeline/timeline_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class TimelineFormController extends GetxController {
  final _timelineRepo = TimelineRepository.instance;

  RxBool isLoading = false.obs;

  DateTime? startDate;
  DateTime? endDate;

  TextEditingController nameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  final String projectId;
  final bool isEdit;
  TimelineDM? timeline = TimelineDM();

  TimelineFormController({
    required this.projectId,
    this.isEdit = false,
    this.timeline,
  });

  @override
  void onInit() {
    super.onInit();

    if (isEdit) {
      nameController.text = timeline?.name ?? "";
      startDateController.text =
          Helpers().convertDateStringFormat(timeline?.startDate ?? "");
      endDateController.text =
          Helpers().convertDateStringFormat(timeline?.endDate ?? "");
      startDate = DateTime.tryParse(timeline!.startDate ?? "");
      endDate = DateTime.tryParse(timeline!.endDate ?? "");
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

  createTimeline() async {
    isLoading.value = true;

    TimelineFirebase param = TimelineFirebase();
    param.endDate = endDate.toString();
    param.name = nameController.text;
    param.startDate = startDate.toString();
    param.projectId = projectId;

    String timelineId = await _timelineRepo.createTimeline(param);

    if (timelineId.isNotEmpty) {
      Get.back(result: true);
    } else {
      Get.back();
      Helpers().showErrorSnackBar("Failed to create new Timeline");
    }

    isLoading.value = false;
  }

  updateTimeline() async {
    isLoading.value = true;

    TimelineFirebase param = TimelineFirebase();
    param.id = timeline!.id;
    param.endDate = endDate.toString();
    param.name = nameController.text;
    param.startDate = startDate.toString();
    param.projectId = projectId;

    bool isUpdated = await _timelineRepo.updateTimeline(param);

    if (isUpdated) {
      Get.back(result: true);
    } else {
      Get.back();
      Helpers().showErrorSnackBar("Failed to update Timeline");
    }

    isLoading.value = false;
  }
}
