import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class AddTimelineController extends GetxController {
  RxBool isLoading = false.obs;

  DateTime? startDate;
  DateTime? endDate;

  TextEditingController nameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

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

  createTimeline() {
    isLoading.value = true;

    // TODO: create timeline
    Get.back();

    isLoading.value = false;
  }
}
