import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/projectClientVendor/mobile_project_client_vendor.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/projectClientVendor/tablet_project_client_vendor.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/projectPayment/mobile_project_payment.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/projectPayment/tablet_project_payment.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/projectStaff/mobile_project_staff.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/projectStaff/tablet_project_staff.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/projectClientVendor/web_project_client_vendor.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/projectPayment/web_project_payment.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/projectStaff/web_project_staff.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/payment/mobile_payment_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/payment/web_payment_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/payment/tablet_payment_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/task/taskForm/mobile_task_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/task/taskForm/tablet_task_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/task/taskForm/web_task_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/timeline/timelineForm/mobile_timeline_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/timeline/timelineForm/tablet_timeline_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/timeline/timelineForm/web_timeline_form.dart';
import 'package:project_management_thesis_app/pages/responsive_layout.dart';
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
  Rx<ScheduleTaskDM> selectedTask = ScheduleTaskDM().obs;
  RxBool isButtonCloseEnabled = true.obs;

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
    timeline.sort((a, b) => a.startDate!.compareTo(b.startDate!));

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

  mobileSetTimeline(int index) async {
    if (index == tabTimelineList.length - 1) {
      Get.to(
        () => MobileTimelineForm(
          projectId: projectId,
        ),
      )?.then(
        (isCreated) async {
          if (isCreated != null && isCreated) {
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

  tabletSetTimeline(int index) async {
    if (index == tabTimelineList.length - 1) {
      Get.to(
        () => TabletTimelineForm(
          projectId: projectId,
        ),
      )?.then(
        (isCreated) async {
          if (isCreated != null && isCreated) {
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

  setTimeline(int index) async {
    if (index == tabTimelineList.length - 1) {
      Get.to(
        () => WebTimelineForm(
          projectId: projectId,
        ),
      )?.then(
        (isCreated) async {
          if (isCreated != null && isCreated) {
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
    } else {
      task.value = [];
    }

    Helpers.writeLog("task: ${jsonEncode(task)}");

    isLoading.value = false;
  }

  setSelectedTask(ScheduleTaskDM task) {
    if (task.id == selectedTask.value.id) {
      selectedTask.value = ScheduleTaskDM();
    } else {
      selectedTask.value = task;
    }
  }

  mobileEditTask(ScheduleTaskDM task) {
    Get.to(
      () => MobileTaskForm(
        timelineId: selectedTimeline.value.id ?? "",
        isEdit: true,
        task: task,
        staffList: projectStaff,
      ),
    )?.then(
      (isEdited) async {
        if (isEdited != null && isEdited) {
          selectedTask.value = ScheduleTaskDM();
          await getTimelineTask(selectedTimeline.value.id ?? "");
          Helpers().showSuccessSnackBar("Task successfully updated");
        }
      },
    );
  }

  tabletEditTask(ScheduleTaskDM task) {
    Get.to(
      () => TabletTaskForm(
        timelineId: selectedTimeline.value.id ?? "",
        isEdit: true,
        task: task,
        staffList: projectStaff,
      ),
    )?.then(
      (isEdited) async {
        if (isEdited != null && isEdited) {
          selectedTask.value = ScheduleTaskDM();
          await getTimelineTask(selectedTimeline.value.id ?? "");
          Helpers().showSuccessSnackBar("Task successfully updated");
        }
      },
    );
  }

  editTask(ScheduleTaskDM task) {
    Get.to(
      () => WebTaskForm(
        timelineId: selectedTimeline.value.id ?? "",
        isEdit: true,
        task: task,
        staffList: projectStaff,
      ),
    )?.then(
      (isEdited) async {
        if (isEdited != null && isEdited) {
          selectedTask.value = ScheduleTaskDM();
          await getTimelineTask(selectedTimeline.value.id ?? "");
          Helpers().showSuccessSnackBar("Task successfully updated");
        }
      },
    );
  }

  deleteTask(ScheduleTaskDM task) {
    isLoading.value = true;

    Get.dialog(
      AlertDialog(
        title: const CustomText("Delete Task"),
        content:
            CustomText("Are you sure you want to delete ${task.name} task?"),
        actions: [
          CustomButton(
            onPressed: () {
              Get.back();
            },
            text: "Cancel",
          ),
          CustomButton(
            onPressed: () async {
              Get.back();
              bool isDeleted = await _taskRepo.deleteTask(task.id ?? "");

              if (isDeleted) {
                await getTimelineTask(selectedTimeline.value.id ?? "");
                Helpers().showSuccessSnackBar("Task deleted successfully");
              } else {
                Helpers().showErrorSnackBar("Delete task failed");
              }
            },
            text: "Delete",
            color: AssetColor.redButton,
          ),
        ],
      ),
    );

    isLoading.value = false;
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
      return ResponsiveLayout(
        mobileScaffold: MobileStaffProject(
          role: currentUser?.role ?? UserType.staff.name,
          staffList: projectStaff,
          onStaffSelected: (staff) {
            _addStaffToProject(staff.id ?? "");
          },
          onStaffRemoved: (staff) {
            _onRemoveStaff(staff);
          },
        ),
        tabletScaffold: TabletStaffProject(
          role: currentUser?.role ?? UserType.staff.name,
          staffList: projectStaff,
          onStaffSelected: (staff) {
            _addStaffToProject(staff.id ?? "");
          },
          onStaffRemoved: (staff) {
            _onRemoveStaff(staff);
          },
        ),
        desktopScaffold: WebStaffProject(
          role: currentUser?.role ?? UserType.staff.name,
          staffList: projectStaff,
          onStaffSelected: (staff) {
            _addStaffToProject(staff.id ?? "");
          },
          onStaffRemoved: (staff) {
            _onRemoveStaff(staff);
          },
        ),
      );
    } else if (selectedInfoIndex.value == 1) {
      return ResponsiveLayout(
        mobileScaffold: MobileClientVendorProject(
          client: projectClient.value,
          vendors: projectVendor,
        ),
        tabletScaffold: TabletClientVendorProject(
          client: projectClient.value,
          vendors: projectVendor,
        ),
        desktopScaffold: WebClientVendorProject(
          client: projectClient.value,
          vendors: projectVendor,
        ),
      );
    } else if (selectedInfoIndex.value == 2) {
      return ResponsiveLayout(
        mobileScaffold: MobilePaymentProject(
          payments: projectPayment,
          client: projectClient.value,
          vendors: projectVendor,
          currentUser: currentUser ?? UserDM(),
          onCreatePayment: () {
            Helpers.writeLog("Create payment Mobile");
            _mobileAddNewPayment();
          },
          onEditPayment: (payment) {
            _mobileUpdatePayment(payment);
          },
          onDeletePayment: (payment) {
            _deletePayment(payment);
          },
        ),
        tabletScaffold: TabletPaymentProject(
          payments: projectPayment,
          client: projectClient.value,
          vendors: projectVendor,
          currentUser: currentUser ?? UserDM(),
          onCreatePayment: () {
            _tabletAddNewPayment();
          },
          onEditPayment: (payment) {
            _tabletUpdatePayment(payment);
          },
          onDeletePayment: (payment) {
            _deletePayment(payment);
          },
        ),
        desktopScaffold: WebPaymentProject(
          payments: projectPayment,
          client: projectClient.value,
          vendors: projectVendor,
          currentUser: currentUser ?? UserDM(),
          onCreatePayment: () {
            _addNewPayment();
          },
          onEditPayment: (payment) {
            _updatePayment(payment);
          },
          onDeletePayment: (payment) {
            _deletePayment(payment);
          },
        ),
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

  _onRemoveStaff(UserDM staff) {
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

  _mobileAddNewPayment() {
    Get.to(
      () => MobilePaymentForm(
        projectId: projectId,
        vendorList: projectVendor,
      ),
    )?.then(
      (isCreated) async {
        if (isCreated != null && isCreated) {
          await getProjectPayment();
          Helpers().showSuccessSnackBar("Payment created successfully");
        }
      },
    );
  }

  _tabletAddNewPayment() {
    Get.to(
      () => TabletPaymentForm(
        projectId: projectId,
        vendorList: projectVendor,
      ),
    )?.then(
      (isCreated) async {
        if (isCreated != null && isCreated) {
          await getProjectPayment();
          Helpers().showSuccessSnackBar("Payment created successfully");
        }
      },
    );
  }

  _addNewPayment() {
    Get.to(
      () => WebPaymentForm(
        projectId: projectId,
        vendorList: projectVendor,
      ),
    )?.then(
      (isCreated) async {
        if (isCreated != null && isCreated) {
          await getProjectPayment();
          Helpers().showSuccessSnackBar("Payment created successfully");
        }
      },
    );
  }

  _mobileUpdatePayment(PaymentDM payment) {
    Get.to(
      () => MobilePaymentForm(
        projectId: projectId,
        vendorList: projectVendor,
        isEdit: true,
        payment: payment,
      ),
    )?.then(
      (isEdited) async {
        if (isEdited != null && isEdited) {
          await getProjectPayment();
          Helpers().showSuccessSnackBar("Payment updated successfully");
        }
      },
    );
  }

  _tabletUpdatePayment(PaymentDM payment) {
    Get.to(
      () => TabletPaymentForm(
        projectId: projectId,
        vendorList: projectVendor,
        isEdit: true,
        payment: payment,
      ),
    )?.then(
      (isEdited) async {
        if (isEdited != null && isEdited) {
          await getProjectPayment();
          Helpers().showSuccessSnackBar("Payment updated successfully");
        }
      },
    );
  }

  _updatePayment(PaymentDM payment) {
    Get.to(
      () => WebPaymentForm(
        projectId: projectId,
        vendorList: projectVendor,
        isEdit: true,
        payment: payment,
      ),
    )?.then(
      (isEdited) async {
        if (isEdited != null && isEdited) {
          await getProjectPayment();
          Helpers().showSuccessSnackBar("Payment updated successfully");
        }
      },
    );
  }

  _deletePayment(PaymentDM payment) {
    isLoading.value = true;

    Get.dialog(
      AlertDialog(
        title: const CustomText("Delete Payment"),
        content: CustomText(
            "Are you sure you want to delete ${payment.paymentName} payment?"),
        actions: [
          CustomButton(
            onPressed: () {
              Get.back();
            },
            text: "Cancel",
          ),
          CustomButton(
            onPressed: () async {
              Get.back();
              bool isDeleted =
                  await _paymentRepo.deletePayment(payment.id ?? "");

              if (isDeleted) {
                await getProjectPayment();
                Helpers().showSuccessSnackBar("Payment deleted successfully");
              } else {
                Helpers().showErrorSnackBar("Delete payment failed");
              }
            },
            text: "Delete",
            color: AssetColor.redButton,
          ),
        ],
      ),
    );

    isLoading.value = false;
  }

  void updateInfoController(int value) {
    selectedInfoIndex.value = value;
    tabInfoController.animateTo(value);
  }

  mobileEditTimeline() {
    Get.to(
      () => MobileTimelineForm(
        projectId: projectId,
        isEdit: true,
        timeline: selectedTimeline.value,
      ),
    )?.then(
      (isEdited) async {
        if (isEdited != null && isEdited) {
          await getProjectTimeline();
          Helpers().showSuccessSnackBar("Timeline successfully updated");
        }
      },
    );
  }

  tabletEditTimeline() {
    Get.to(
      () => TabletTimelineForm(
        projectId: projectId,
        isEdit: true,
        timeline: selectedTimeline.value,
      ),
    )?.then(
      (isEdited) async {
        if (isEdited != null && isEdited) {
          await getProjectTimeline();
          Helpers().showSuccessSnackBar("Timeline successfully updated");
        }
      },
    );
  }

  editTimeline() {
    Get.to(
      () => WebTimelineForm(
        projectId: projectId,
        isEdit: true,
        timeline: selectedTimeline.value,
      ),
    )?.then(
      (isEdited) async {
        if (isEdited != null && isEdited) {
          await getProjectTimeline();
          Helpers().showSuccessSnackBar("Timeline successfully updated");
        }
      },
    );
  }

  deleteTimeline() {
    isLoading.value = true;

    Get.dialog(
      AlertDialog(
        title: const CustomText("Delete Timeline"),
        content: CustomText(
            "Are you sure you want to delete ${selectedTimeline.value.name} timeline?"),
        actions: [
          CustomButton(
            onPressed: () {
              Get.back();
            },
            text: "Cancel",
          ),
          CustomButton(
            onPressed: () async {
              Get.back();
              bool isDeleted = await _timelineRepo
                  .deleteTimeline(selectedTimeline.value.id ?? "");

              if (isDeleted) {
                tabTimelineList.remove(selectedTimeline.value.name);
                await getProjectTimeline();
                Helpers().showSuccessSnackBar("Timeline deleted successfully");
              } else {
                Helpers().showErrorSnackBar("Delete timeline failed");
              }
            },
            text: "Delete",
            color: AssetColor.redButton,
          ),
        ],
      ),
    );

    isLoading.value = false;
  }

  mobileAddTask() {
    Get.to(
      () => MobileTaskForm(
        timelineId: selectedTimeline.value.id ?? "",
        staffList: projectStaff,
      ),
    )?.then(
      (isCreated) async {
        if (isCreated) {
          await getTimelineTask(selectedTimeline.value.id ?? "");
          Helpers().showSuccessSnackBar("Task created successfully");
        } else {
          Helpers().showErrorSnackBar("Create task failed");
        }
      },
    );
  }

  tabletAddTask() {
    Get.to(
      () => TabletTaskForm(
        timelineId: selectedTimeline.value.id ?? "",
        staffList: projectStaff,
      ),
    )?.then(
      (isCreated) async {
        if (isCreated) {
          await getTimelineTask(selectedTimeline.value.id ?? "");
          Helpers().showSuccessSnackBar("Task created successfully");
        } else {
          Helpers().showErrorSnackBar("Create task failed");
        }
      },
    );
  }

  addTask() {
    Get.to(
      () => WebTaskForm(
        timelineId: selectedTimeline.value.id ?? "",
        staffList: projectStaff,
      ),
    )?.then(
      (isCreated) async {
        if (isCreated) {
          await getTimelineTask(selectedTimeline.value.id ?? "");
          Helpers().showSuccessSnackBar("Task created successfully");
        } else {
          Helpers().showErrorSnackBar("Create task failed");
        }
      },
    );
  }
}
