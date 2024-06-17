import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/client/select_client.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/vendor/select_vendor.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/project/firebaseModel/project_firebase.dart';
import 'package:project_management_thesis_app/repository/project/project_repository.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class AddProjectController extends GetxController {
  final _projectRepo = ProjectRepository.instance;
  final _clientRepo = ClientRepository.instance;
  final _vendorRepo = VendorRepository.instance;

  RxBool isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  Rx<ClientDM> chosenClient = ClientDM().obs;
  RxList<VendorDM> selectedVendor = <VendorDM>[].obs;

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

    Helpers.writeLog("startDate: ${startDate.toString()}");
  }

  selectClient() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AssetColor.whiteBackground,
        content: SelectClient(
          initialClient: chosenClient.value,
          onClientSelected: (client) {
            chosenClient.value = client;
          },
        ),
      ),
    );
  }

  removeClient() {
    chosenClient.value = ClientDM();
  }

  selectVendor() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AssetColor.whiteBackground,
        content: SelectVendor(
          onVendorSelected: (vendor) {
            // TODO: ADD SELECTED VENDOR
            selectedVendor.add(vendor);
          },
          selectedVendor: selectedVendor,
        ),
      ),
    );
  }

  removeVendor(VendorDM vendor) {
    selectedVendor.remove(vendor);
  }

  createProject() async {
    isLoading.value = true;

    ProjectFirebase param = ProjectFirebase();
    param.clientId = chosenClient.value.id;
    param.description = descriptionController.text;
    param.name = nameController.text;
    param.startDate = startDate.toString();
    param.endDate = endDate.toString();
    param.status = ProjectStatusType.pending.name;
    param.userId = [];

    List<String> vendorId = [];
    for (var element in selectedVendor) {
      vendorId.add(element.id ?? "");
    }
    param.vendorId = vendorId;

    Helpers.writeLog("param: ${param.toFirestore()}");

    String projectId = await _projectRepo.createProject(param);

    Helpers.writeLog("projectId: $projectId");

    if (projectId.isNotEmpty) {
      _clientRepo.addClientProjectId(chosenClient.value.id, projectId);
      for (var element in selectedVendor) {
        _vendorRepo.addVendorProjectId(element.id ?? "", projectId);
      }

      Get.back();
      Helpers().showSuccessSnackBar("Project is waiting for approval");
    } else {
      Helpers().showErrorSnackBar("Failed to create project");
    }

    isLoading.value = false;
  }
}
