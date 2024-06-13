import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/client/select_client.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class AddProjectController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController clientController = TextEditingController();

  Rx<ClientDM> chosenClient = ClientDM().obs;

  DateTime? startDate;
  DateTime? endDate;

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

  selectClient() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AssetColor.whiteBackground,
        content: SelectClient(
          initialClient: chosenClient.value,
          onClientSelected: (client) {
            chosenClient.value = client;
            clientController.text = client.name ?? "";
          },
        ),
      ),
    );
  }
}
