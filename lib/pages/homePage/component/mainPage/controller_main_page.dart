import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectAdd/project_add.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/project_detail.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/project_pending_detail.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/project_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class MainPageController extends GetxController with Storage {
  final _userRepo = UserRepository.instance;
  final _vendorRepo = VendorRepository.instance;
  final _clientRepo = ClientRepository.instance;
  final _projectRepo = ProjectRepository.instance;

  RxList<UserDM> users = <UserDM>[].obs;
  RxList<VendorDM> vendors = <VendorDM>[].obs;
  RxList<ClientDM> clients = <ClientDM>[].obs;
  RxList<ProjectDM> projects = <ProjectDM>[].obs;
  RxList<ProjectDM> pendingProjects = <ProjectDM>[].obs;
  Rx<UserDM> currentUser = UserDM().obs;

  RxBool isHoverListProject = false.obs;
  RxInt selectedIndexProject = (-1).obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await _getAllUser();
    await _getCurrentUser();
    await _getAllVendors();
    await _getAllClients();
    await _getAllProjects();
    isLoading.value = false;
  }

  _getCurrentUser() async {
    currentUser.value = await getUserData() ?? UserDM();
    Helpers.writeLog("currentUser: ${jsonEncode(currentUser.value)}");
  }

  _getAllUser() async {
    users.value = await _userRepo.getAllUser();
  }

  _getAllVendors() async {
    vendors.value = await _vendorRepo.getAllVendor();
  }

  _getAllClients() async {
    clients.value = await _clientRepo.getAllClient();
  }

  _getAllProjects() async {
    projects.value = await _projectRepo.getAllProjects();

    for (var project in projects) {
      project.clientName =
          clients.firstWhere((element) => element.id == project.clientId).name;
    }

    pendingProjects.value = projects
        .where((element) => element.status == ProjectStatusType.pending.name)
        .toList();
  }

  showPendingDetail(ProjectDM project) {
    List<VendorDM> projectVendor = vendors
        .where((element) => project.vendorId!.contains(element.id))
        .toList();

    ClientDM projectClient =
        clients.firstWhere((element) => element.id == project.clientId);

    Helpers.writeLog("projectVendor: ${jsonEncode(projectVendor)}");

    Get.dialog(
      AlertDialog(
        backgroundColor: AssetColor.greyBackground,
        title: const CustomText(
          "Project Detail",
          fontSize: 28,
          color: AssetColor.blackPrimary,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
        content: PendingProjectDetail(
          project: project,
          client: projectClient,
          vendors: projectVendor,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        actions: [
          CustomButton(
            onPressed: () => Get.back(),
            text: "Decline",
            color: AssetColor.redButton,
            textColor: AssetColor.whiteBackground,
            borderRadius: 8,
          ),
          CustomButton(
            onPressed: () => {
              // TODO: Update Aprrove Operation
            },
            text: "Approve",
            color: AssetColor.greenButton,
            textColor: AssetColor.whiteBackground,
            borderRadius: 8,
          ),
        ],
      ),
    );
  }

  createProject() {
    Get.to(() => const AddProject());
  }

  setHoverValue(bool value, int index) {
    isHoverListProject.value = value;
    selectedIndexProject.value = index;
  }

  showProjectDetail(String projectId) {
    Get.to(
      () => ProjectDetail(
        projectId: projectId,
      ),
    );
  }
}
