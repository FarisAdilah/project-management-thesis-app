import 'dart:convert';

import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/project_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class VendorDetailController extends GetxController with Storage {
  final _projectRepo = ProjectRepository.instance;

  VendorDM vendor;

  VendorDetailController({required this.vendor});

  RxBool isLoading = false.obs;
  RxList<ProjectDM> projects = <ProjectDM>[].obs;

  UserDM? currentUser = UserDM();

  @override
  void onInit() async {
    super.onInit();

    isLoading.value = true;

    currentUser = await getUserData();

    if (vendor.projectId?.isNotEmpty ?? false) {
      var projectData = await _projectRepo.getMultipleProjects(
        vendor.id ?? "",
        ProjectFieldType.vendorId,
      );
      Helpers.writeLog("projectData: ${jsonEncode(projectData)}");
      if (projectData.isNotEmpty) {
        projects.value = projectData;
      }
    }

    Helpers.writeLog("projects: ${projects.toJson()}");

    isLoading.value = false;
  }
}
