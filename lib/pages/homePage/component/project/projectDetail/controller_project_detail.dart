import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/project_client_vendor.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/project_payment.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/project_staff.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/timeline/timeline_add.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/repository/payment/payment_repository.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/project_repository.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/dataModel/schedule_task_dm.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/schedule_task_repository.dart';
import 'package:project_management_thesis_app/repository/timeline/dataModel/timeline_dm.dart';
import 'package:project_management_thesis_app/repository/timeline/timeline_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class ProjectDetailController extends GetxController
    with GetTickerProviderStateMixin, Storage {
  final _projectRepo = ProjectRepository.instance;
  final _timelineRepo = TimelineRepository.instance;
  final _userRepo = UserRepository.instance;
  final _clientRepo = ClientRepository.instance;
  final _vendorRepo = VendorRepository.instance;
  final _taskRepo = ScheduleTaskRepository.instance;
  final _paymentRepo = PaymentRepository.instance;
  final String projectId;

  UserDM? currentUser;

  RxBool isLoading = false.obs;
  Rx<ProjectDM> project = ProjectDM().obs;
  Rx<UserDM> projectPM = UserDM().obs;
  RxList<TimelineDM> projectTimeline = <TimelineDM>[].obs;
  Rx<ClientDM> projectClient = ClientDM().obs;
  RxList<VendorDM> projectVendor = <VendorDM>[].obs;
  RxList<UserDM> projectStaff = <UserDM>[].obs;
  RxList<PaymentDM> projectPayment = <PaymentDM>[].obs;

  Rx<TimelineDM> selectedTimeline = TimelineDM().obs;
  RxList<ScheduleTaskDM> task = <ScheduleTaskDM>[].obs;

  ProjectDetailController({required this.projectId});

  late TabController tabInfoController;
  late TabController tabTimelineController;
  RxList<String> tabTimelineList = <String>["add"].obs;
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
    currentUser = await getUserData();
    await getProjectData();
    await getProjectTimeline();
    await getProjectStaff();
    await getProjectClient();
    await getProjectVendor();
    await getProjectPayment();
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
      setTimeline(0);
    }

    Helpers.writeLog("projectTimeline: ${jsonEncode(timeline)}");

    isLoading.value = false;
  }

  getProjectStaff() async {
    isLoading.value = true;

    var staff = await _userRepo.getMultipleUserByProject(projectId);
    if (staff.isNotEmpty) {
      projectStaff.value =
          staff.where((element) => element.id != project.value.pmId).toList();
    }

    var projectManager = await _userRepo.getUserById(project.value.pmId ?? "");
    if (projectManager.id?.isNotEmpty ?? false) {
      projectPM.value = projectManager;
    }

    Helpers.writeLog("projectStaff: ${jsonEncode(projectStaff)}");
    Helpers.writeLog("projectPM: ${jsonEncode(projectPM)}");

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

  setTimeline(int index) async {
    if (index == tabTimelineList.length - 1) {
      Get.to(
        () => AddTimeline(
          projectId: projectId,
        ),
      )?.then(
        (isCreated) async {
          if (isCreated) {
            await getProjectTimeline();
          }
        },
      );
      tabTimelineController.animateTo(0);
    } else {
      tabTimelineController.index = index;
      selectedTimeline.value = projectTimeline[index];
      await getTimelineTask(selectedTimeline.value.id ?? "");
    }
  }

  getTimelineTask(String timelineId) async {
    isLoading.value = true;

    var taskData = await _taskRepo.getMultipleScheduleTask(
      timelineId,
      TaskFieldType.timelineId,
    );
    if (taskData.isNotEmpty) {
      task.value = taskData;
    }

    Helpers.writeLog("task: ${jsonEncode(task)}");

    isLoading.value = false;
  }

  UserDM getStaffofTask(staffId) {
    var staff =
        projectStaff.firstWhereOrNull((element) => element.id == staffId);
    return staff ?? UserDM();
  }

  getProjectPayment() async {
    isLoading.value = true;

    var payment = await _paymentRepo.getMultiplePayment(projectId);
    if (payment.isNotEmpty) {
      projectPayment.value = payment;
    }

    Helpers.writeLog("projectPayment: ${jsonEncode(payment)}");

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
    tabInfoController.dispose();
    super.dispose();
  }

  Widget getInfoWidget() {
    if (selectedInfoIndex.value == 0) {
      return StaffProject(
        role: currentUser?.role ?? UserType.staff.name,
        staffList: projectStaff,
        onStaffSelected: (staff) {
          _addStaffToProject(staff.id ?? "");
        },
        onStaffRemoved: (staff) {
          Get.dialog(
            AlertDialog(
              title: const CustomText("Remove Staff"),
              content: CustomText(
                  "Are you sure you want to remove ${staff.name} from this project?"),
              actions: [
                CustomButton(
                  onPressed: () {
                    Get.back();
                  },
                  text: "Cancel",
                ),
                CustomButton(
                  onPressed: () {
                    Get.back();
                    _removeStaffFromProject(staff.id ?? "");
                  },
                  text: "Remove",
                  color: AssetColor.redButton,
                ),
              ],
            ),
          );
        },
      );
    } else if (selectedInfoIndex.value == 1) {
      return ClientVendorProject(
        client: projectClient.value,
        vendors: projectVendor,
      );
    } else if (selectedInfoIndex.value == 2) {
      return PaymentProject(
        projectId: projectId,
        payments: projectPayment,
        onCreatePayment: (newPayment) {
          // TODO: Create New Payment Integration
        },
      );
    } else {
      return Container();
    }
  }

  _addStaffToProject(String userId) async {
    isLoading.value = true;

    bool isAdded = await _userRepo.addUserProjectId(userId, projectId);

    if (isAdded) {
      bool isUpdated = await _projectRepo.addProjectStaff(projectId, userId);

      if (isUpdated) {
        await getProjectData();
        await getProjectStaff();
        Helpers().showSuccessSnackBar("Staff added successfully");
      } else {
        Helpers().showErrorSnackBar("Add staff failed");
      }
    }
  }

  _removeStaffFromProject(String userId) async {
    isLoading.value = true;

    bool isRemoved = await _userRepo.removeUserProjectId(userId, projectId);

    if (isRemoved) {
      bool isUpdated = await _projectRepo.removeProjectStaff(projectId, userId);

      if (isUpdated) {
        await getProjectData();
        await getProjectStaff();
        Helpers().showSuccessSnackBar("Staff removed successfully");
      } else {
        Helpers().showErrorSnackBar("Remove staff failed");
      }
    }
  }

  void updateInfoController(int value) {
    selectedInfoIndex.value = value;
    tabInfoController.animateTo(value);
  }

  void editTimeline() {}

  void deleteTimeline() {}
}
