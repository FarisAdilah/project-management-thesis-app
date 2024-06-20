import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/client/select_client.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/staff/select_staff.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/vendor/select_vendor.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/firebaseModel/project_firebase.dart';
import 'package:project_management_thesis_app/repository/project/project_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ProjectFormController extends GetxController {
  final _projectRepo = ProjectRepository.instance;
  final _clientRepo = ClientRepository.instance;
  final _vendorRepo = VendorRepository.instance;
  final _staffRepo = UserRepository.instance;

  RxBool isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  Rx<ClientDM> chosenClient = ClientDM().obs;
  RxList<VendorDM> selectedVendor = <VendorDM>[].obs;
  RxList<UserDM> projectManagerList = <UserDM>[].obs;
  Rx<UserDM> chosenProjectManager = UserDM().obs;

  DateTime? startDate;
  DateTime? endDate;

  final bool isEdit;
  final ProjectDM? project;

  ProjectFormController({
    this.isEdit = false,
    this.project,
  });

  @override
  void onInit() async {
    super.onInit();
    await getPmList();

    if (isEdit) {
      nameController.text = project?.name ?? "";
      descriptionController.text = project?.description ?? "";

      startDate = DateTime.tryParse(project?.startDate ?? "");
      startDateController.text = Helpers().convertDateStringFormat(
        project?.startDate ?? "",
      );
      Helpers.writeLog("startDate: ${startDate.toString()}");
      endDate = DateTime.tryParse(project?.endDate ?? "");
      endDateController.text = Helpers().convertDateStringFormat(
        project?.endDate ?? "",
      );
      Helpers.writeLog("endDate: ${endDate.toString()}");

      var client = await _clientRepo.getClientById(project?.clientId ?? "");
      if (client.id?.isNotEmpty ?? false) {
        chosenClient.value = client;
      }

      var projectManager = await _staffRepo.getUserById(project?.pmId ?? "");
      if (projectManager.id?.isNotEmpty ?? false) {
        chosenProjectManager.value = projectManager;
      }

      for (var element in project?.vendorId ?? []) {
        var vendor = await _vendorRepo.getVendorById(element);
        if (vendor.id?.isNotEmpty ?? false) {
          selectedVendor.add(vendor);
        }
      }
    }
  }

  getPmList() async {
    isLoading.value = true;

    List<UserDM> pmList = await _staffRepo.getMupltipleUserByRole(
      UserType.projectManager.name,
    );

    if (pmList.isNotEmpty) {
      projectManagerList.value = pmList;
    }

    isLoading.value = false;
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

  selectProjectManager() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AssetColor.whiteBackground,
        content: SelectStaff(
          initialStaff: chosenProjectManager.value,
          userRole: UserType.projectManager.name,
          selectedStaffList: const [],
          onStaffSelected: (projectManager) {
            chosenProjectManager.value = projectManager;
          },
          title: "Select Project Manager",
          searchHint: "Search Project Manager",
          textButton: "Select",
        ),
      ),
    );
  }

  removeProjectManager() {
    chosenProjectManager.value = UserDM();
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
    param.pmId = chosenProjectManager.value.id;

    Helpers.writeLog("param: ${param.toFirestore()}");

    String projectId = await _projectRepo.createProject(param);

    Helpers.writeLog("projectId: $projectId");

    if (projectId.isNotEmpty) {
      _clientRepo.addClientProjectId(chosenClient.value.id, projectId);
      for (var element in selectedVendor) {
        _vendorRepo.addVendorProjectId(element.id ?? "", projectId);
      }
      _staffRepo.addUserProjectId(
        chosenProjectManager.value.id ?? "",
        projectId,
      );

      Get.back();
      Helpers().showSuccessSnackBar("Project is waiting for approval");
    } else {
      Helpers().showErrorSnackBar("Failed to create project");
    }

    isLoading.value = false;
  }

  reviseProject() async {
    isLoading.value = true;

    ProjectFirebase param = ProjectFirebase();
    param.id = project?.id ?? "";
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
    param.pmId = chosenProjectManager.value.id;

    bool isUpdated = await _projectRepo.updateProject(param);

    if (isUpdated) {
      Get.back(result: true);
      Helpers.writeLog("Project has been revised");
      Helpers().showSuccessSnackBar("Project has been revised");
    } else {
      Helpers.writeLog("Failed to revise project");
      Helpers().showErrorSnackBar("Failed to revise project");
    }
  }
}
