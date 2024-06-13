import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/project_client_vendor.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/project_payment.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/project_staff.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/project_repository.dart';
import 'package:project_management_thesis_app/repository/timeline/dataModel/timeline_dm.dart';
import 'package:project_management_thesis_app/repository/timeline/timeline_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ProjectDetailController extends GetxController
    with GetTickerProviderStateMixin {
  final _projectRepo = ProjectRepository.instance;
  final _timelineRepo = TimelineRepository.instance;
  final _userRepo = UserRepository.instance;
  final _clientRepo = ClientRepository.instance;
  final _vendorRepo = VendorRepository.instance;
  final String projectId;

  RxBool isLoading = false.obs;
  Rx<ProjectDM> project = ProjectDM().obs;
  RxList<TimelineDM> projectTimeline = <TimelineDM>[].obs;
  Rx<ClientDM> projectClient = ClientDM().obs;
  RxList<VendorDM> projectVendor = <VendorDM>[].obs;
  RxList<UserDM> projectStaff = <UserDM>[].obs;

  ProjectDetailController({required this.projectId});

  late TabController tabInfoController;
  late TabController tabTimelineController;
  RxList<String> tabTimelineList = <String>["Timeline 1,", "Timeline 2"].obs;
  RxList<String> tabInfoList =
      <String>["Staff List", "Client & Vendor List", "Payment"].obs;
  RxInt selectedInfoIndex = (0).obs;

  @override
  void onInit() async {
    super.onInit();
    tabTimelineController = TabController(
      length: tabTimelineList.length,
      vsync: this,
      initialIndex: 0,
    );
    tabInfoController = TabController(
      length: tabInfoList.length,
      vsync: this,
      initialIndex: 0,
    );
    await getProjectData();
    await getProjectTimeline();
    await getProjectStaff();
    await getProjectClient();
    await getProjectVendor();
  }

  getProjectData() async {
    isLoading.value = true;

    var projectData = await _projectRepo.getProjectById(projectId);
    if (projectData != null) {
      project.value = projectData;
    }

    Helpers.writeLog("project: ${jsonEncode(project.value)}");

    isLoading.value = false;
  }

  getProjectTimeline() async {
    isLoading.value = true;

    var timeline = await _timelineRepo.getMultipleTimeline(projectId);
    if (timeline.isNotEmpty) {
      projectTimeline.value = timeline;
      tabTimelineList.value = timeline.map((e) => e.name ?? "").toList();
      tabTimelineList.add("add");
      tabTimelineController = TabController(
        length: tabTimelineList.length,
        vsync: this,
        initialIndex: 0,
      );
    }

    Helpers.writeLog("projectTimeline: ${jsonEncode(timeline)}");

    isLoading.value = false;
  }

  getProjectStaff() async {
    isLoading.value = true;

    var staff = await _userRepo.getMultipleUserByProject(projectId);
    if (staff.isNotEmpty) {
      projectStaff.value = staff;
    }

    Helpers.writeLog("projectStaff: ${jsonEncode(projectStaff)}");

    isLoading.value = false;
  }

  getProjectClient() async {
    isLoading.value = true;

    var client = await _clientRepo.getClientById(project.value.clientId ?? "");
    if (client.id?.isNotEmpty ?? false) {
      projectClient.value = client;
    }

    Helpers.writeLog("projectClient: ${jsonEncode(projectClient)}");

    isLoading.value = false;
  }

  getProjectVendor() async {
    isLoading.value = true;

    var vendor = await _vendorRepo.getMultipleVendor(projectId);
    if (vendor.isNotEmpty) {
      projectVendor.value = vendor;
    }

    Helpers.writeLog("projectVendor: ${jsonEncode(projectVendor)}");

    isLoading.value = false;
  }

  Color getStatusColor(String status) {
    if (status == ProjectStatusType.pending.name) {
      return AssetColor.redButton;
    } else if (status == ProjectStatusType.ongoing.name) {
      return AssetColor.orange;
    } else if (status == ProjectStatusType.closing.name) {
      return AssetColor.redButton;
    } else if (status == ProjectStatusType.completed.name) {
      return AssetColor.greenButton;
    } else {
      return AssetColor.orange;
    }
  }

  String getStatusText(String status) {
    Helpers.writeLog("status: $status");
    if (status == ProjectStatusType.pending.name) {
      return "Pending";
    } else if (status == ProjectStatusType.ongoing.name) {
      return "Ongoing";
    } else if (status == ProjectStatusType.closing.name) {
      return "Closing";
    } else if (status == ProjectStatusType.completed.name) {
      return "Completed";
    } else {
      return "Unknown status";
    }
  }

  @override
  void dispose() {
    tabTimelineController.dispose();
    super.dispose();
  }

  Widget getInfoWidget() {
    if (selectedInfoIndex.value == 0) {
      return StaffProject(
        staffList: projectStaff,
        onStaffSelected: (staff) {
          // TODO: ADD STAFF TO PROJECT
        },
      );
    } else if (selectedInfoIndex.value == 1) {
      return const ClientVendorProject();
    } else if (selectedInfoIndex.value == 2) {
      return const PaymentProject();
    } else {
      return Container();
    }
  }

  void updateInfoController(int value) {
    selectedInfoIndex.value = value;
    tabInfoController.animateTo(value);
  }
}
