import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/timeline/firebaseModel/timeline_firebase.dart';
import 'package:project_management_thesis_app/repository/timeline/timeline_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class AddTimelineController extends GetxController {
  final _timelineRepo = TimelineRepository.instance;

  RxBool isLoading = false.obs;

  DateTime? startDate;
  DateTime? endDate;

  TextEditingController nameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  final String projectId;

  AddTimelineController({
    required this.projectId,
  });

  selectDatePicker(
    BuildContext context,
    TextEditingController dateController,
  ) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: startDate ?? DateTime.now(),
      lastDate: endDate ?? DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      dateController.text =
          Helpers().convertDateStringFormat(selectedDate.toString());
      if (dateController == startDateController) {
        startDate = selectedDate;
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
}
