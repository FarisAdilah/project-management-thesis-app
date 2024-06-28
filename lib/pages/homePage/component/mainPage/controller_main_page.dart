import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/subComponent/pendingPayment/pending_payment.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/subComponent/pendingPayment/pending_payment_detail.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/subComponent/pendingProject/pending_project.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/mobile_project_detail.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/tablet_project_detail.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectForm/mobile_project_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectForm/tablet_project_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectForm/web_project_form.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/web_project_detail.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/project_pending_detail.dart';
import 'package:project_management_thesis_app/pages/responsive_layout.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/repository/payment/payment_repository.dart';
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
  final _paymentRepo = PaymentRepository.instance;

  RxList<UserDM> users = <UserDM>[].obs;
  RxList<VendorDM> vendors = <VendorDM>[].obs;
  RxList<ClientDM> clients = <ClientDM>[].obs;
  RxList<ProjectDM> projects = <ProjectDM>[].obs;
  RxList<ProjectDM> pendingProjects = <ProjectDM>[].obs;
  RxList<PaymentDM> pendingPayments = <PaymentDM>[].obs;
  RxList<ProjectDM> closingProjects = <ProjectDM>[].obs;

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
    await _getAllPayments();
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

    if (currentUser.value.role == UserType.supervisor.name) {
      pendingProjects.value = projects
          .where((element) => element.status == ProjectStatusType.pending.name)
          .toList();
      closingProjects.value = projects
          .where((element) =>
              element.status == ProjectStatusType.pendingClose.name)
          .toList();
    } else if (currentUser.value.role == UserType.admin.name) {
      pendingProjects.value = projects
          .where((element) => element.status == ProjectStatusType.rejected.name)
          .toList();
      closingProjects.value = projects
          .where((element) =>
              element.status == ProjectStatusType.rejectClose.name ||
              element.status == ProjectStatusType.closing.name)
          .toList();
    }
  }

  _getAllPayments() async {
    pendingPayments.value = await _paymentRepo.getAllPayment();

    if (currentUser.value.role == UserType.admin.name) {
      pendingPayments.value = pendingPayments
          .where((element) => element.status == PaymentStatusType.pending.name)
          .toList();
    } else if (currentUser.value.role == UserType.projectManager.name) {
      pendingPayments.value = pendingPayments
          .where((element) => element.status == PaymentStatusType.rejected.name)
          .toList();
    }
  }

  getPendingWidget() {
    if (currentUser.value.role == UserType.supervisor.name &&
        pendingProjects.isNotEmpty) {
      return PendingProject(
        pendingProjects: pendingProjects,
        showPendingDetail: (project) {
          showPendingDetail(project);
        },
      );
    } else if (currentUser.value.role == UserType.admin.name &&
        pendingProjects.isNotEmpty) {
      return PendingProject(
        pendingProjects: pendingProjects,
        showPendingDetail: (project) {
          showPendingDetail(project);
        },
        isAdmin: true,
      );
    } else {
      return const SizedBox();
    }
  }

  showPendingDetail(ProjectDM project, {bool isClosing = false}) {
    Helpers.writeLog("project: ${jsonEncode(project)}");
    List<VendorDM> projectVendor = vendors
        .where((element) => project.vendorId!.contains(element.id))
        .toList();

    ClientDM projectClient =
        clients.firstWhere((element) => element.id == project.clientId);

    Helpers.writeLog("projectClient: ${jsonEncode(users)}");
    UserDM? projectManager = users.firstWhereOrNull(
      (element) => element.id == project.pmId,
    );

    bool isAdmin = currentUser.value.role == UserType.admin.name;

    Helpers.writeLog("projectClient: ${jsonEncode(projectClient)}");
    Helpers.writeLog("projectVendor: ${jsonEncode(projectVendor)}");
    Helpers.writeLog("projectManager: ${jsonEncode(projectManager)}");

    Get.dialog(
      AlertDialog(
        backgroundColor: AssetColor.whiteBackground,
        content: PendingProjectDetail(
          project: project,
          client: projectClient,
          vendors: projectVendor,
          projectManager: projectManager ?? UserDM(),
          isAdmin: isAdmin,
          isClosing: isClosing,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        actions: [
          isClosing
              ? const SizedBox()
              : CustomButton(
                  onPressed: () {
                    if (isAdmin) {
                      Get.dialog(
                        AlertDialog(
                          title: const CustomText("Delete Project"),
                          content: const CustomText(
                            "Are you sure you want to delete this project?",
                          ),
                          actions: [
                            CustomButton(
                              onPressed: () {
                                deleteProject(project.id ?? "");
                                Get.back();
                              },
                              text: "Yes",
                              color: AssetColor.redButton,
                              textColor: AssetColor.whiteBackground,
                              borderRadius: 8,
                            ),
                            CustomButton(
                              onPressed: () => Get.back(),
                              text: "No",
                              color: AssetColor.orangeButton,
                              textColor: AssetColor.whiteBackground,
                              borderRadius: 8,
                            ),
                          ],
                        ),
                      );
                    } else {
                      updateProjectStatus(
                        project.id ?? "",
                        ProjectStatusType.rejected.name,
                      );
                    }
                  },
                  text: isAdmin ? "Delete" : "Decline",
                  color: AssetColor.redButton,
                  textColor: AssetColor.whiteBackground,
                  borderRadius: 8,
                ),
          CustomButton(
            onPressed: () => {
              if (isAdmin)
                {
                  if (isClosing)
                    updateProjectStatus(
                      project.id ?? "",
                      ProjectStatusType.pendingClose.name,
                    ),
                  Get.back(),
                  Get.to(
                    () => WebProjectForm(
                      project: project,
                      isEdit: true,
                    ),
                  )?.then(
                    (isUpdated) {
                      if (isUpdated) _getAllProjects();
                    },
                  )
                }
              else
                {
                  updateProjectStatus(
                    project.id ?? "",
                    ProjectStatusType.ongoing.name,
                  ),
                }
            },
            text: isClosing
                ? isAdmin
                    ? "Submit Close Project Document"
                    : "Approve"
                : "Approve",
            color: isAdmin ? AssetColor.orangeButton : AssetColor.greenButton,
            textColor: AssetColor.whiteBackground,
            borderRadius: 8,
          ),
        ],
      ),
    );
  }

  getPendingPayment() {
    if (currentUser.value.role == UserType.admin.name) {
      return PendingPayment(
        pendingPayments: pendingPayments,
        showPendingDetail: showPendingPaymentDetail,
      );
    } else if (currentUser.value.role == UserType.projectManager.name) {
      return PendingPayment(
        pendingPayments: pendingPayments,
        showPendingDetail: showPendingPaymentDetail,
        isPm: true,
      );
    } else {
      return const SizedBox();
    }
  }

  showPendingPaymentDetail(PaymentDM payment) {
    Helpers.writeLog("payment: ${jsonEncode(payment)}");
    VendorDM vendor =
        vendors.where((element) => payment.vendorId == element.id).first;

    ClientDM client =
        clients.firstWhere((element) => element.id == payment.clientId);

    bool isPm = currentUser.value.role == UserType.projectManager.name;

    Helpers.writeLog("projectVendor: ${jsonEncode(vendor)}");

    Get.dialog(
      AlertDialog(
        backgroundColor: AssetColor.whiteBackground,
        content: PendingPaymentDetail(
          payment: payment,
          client: client,
          vendors: vendor,
          isPm: isPm,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        actions: [
          CustomButton(
            onPressed: () {
              if (isPm) {
                Get.dialog(
                  AlertDialog(
                    title: const CustomText("Delete Payment"),
                    content: const CustomText(
                      "Are you sure you want to delete this payment?",
                    ),
                    actions: [
                      CustomButton(
                        onPressed: () {
                          Get.back();
                          // deleteProject(project.id ?? "");
                        },
                        text: "Yes",
                        color: AssetColor.redButton,
                        textColor: AssetColor.whiteBackground,
                        borderRadius: 8,
                      ),
                      CustomButton(
                        onPressed: () => Get.back(),
                        text: "No",
                        color: AssetColor.orangeButton,
                        textColor: AssetColor.whiteBackground,
                        borderRadius: 8,
                      ),
                    ],
                  ),
                );
              } else {
                updateProjectStatus(
                  payment.id ?? "",
                  ProjectStatusType.rejected.name,
                );
              }
            },
            text: isPm ? "Delete" : "Decline",
            color: AssetColor.redButton,
            textColor: AssetColor.whiteBackground,
            borderRadius: 8,
          ),
          CustomButton(
            onPressed: () => {
              if (isPm)
                {
                  Get.back(),
                  // Get.to(
                  //   () => WebProjectForm(
                  //     project: project,
                  //     isEdit: true,
                  //   ),
                  // )?.then(
                  //   (isUpdated) {
                  //     if (isUpdated) _getAllProjects();
                  //   },
                  // )
                }
              else
                {
                  Get.back(),
                  // updateProjectStatus(
                  //   project.id ?? "",
                  //   ProjectStatusType.ongoing.name,
                  // ),
                }
            },
            text: isPm ? "Edit" : "Approve",
            color: isPm ? AssetColor.orangeButton : AssetColor.greenButton,
            textColor: AssetColor.whiteBackground,
            borderRadius: 8,
          ),
        ],
      ),
    );
  }

  getClosingWidget() {
    if (currentUser.value.role == UserType.supervisor.name &&
        closingProjects.isNotEmpty) {
      return PendingProject(
        pendingProjects: closingProjects,
        showPendingDetail: (project) {
          showPendingDetail(project);
        },
        isClosing: true,
      );
    } else if (currentUser.value.role == UserType.admin.name &&
        closingProjects.isNotEmpty) {
      return PendingProject(
        pendingProjects: closingProjects,
        showPendingDetail: (project) {
          showPendingDetail(project, isClosing: true);
        },
        isAdmin: true,
        isClosing: true,
      );
    } else {
      return const SizedBox();
    }
  }

  createProject() {
    Get.to(
      () => const ResponsiveLayout(
        mobileScaffold: MobileProjectForm(),
        tabletScaffold: TabletProjectForm(),
        desktopScaffold: WebProjectForm(),
      ),
    )?.whenComplete(
      () {
        _getAllProjects();
      },
    );
  }

  updateProjectStatus(String id, String status) async {
    bool isUpdated = await _projectRepo.updateProjectStatus(
      id,
      status,
    );

    if (isUpdated) {
      Get.back();
      Helpers.writeLog("Project has been updated");
      _getAllProjects();
    } else {
      Helpers.writeLog("Failed to update project");
    }
  }

  deleteProject(String id) async {
    isLoading.value = true;

    bool isDeleted = await _projectRepo.deleteProject(id);

    if (isDeleted) {
      Get.back();
      Helpers.writeLog("Project has been deleted");
      _getAllProjects();
    } else {
      Helpers.writeLog("Failed to delete project");
    }

    isLoading.value = false;
  }

  setHoverValue(bool value, int index) {
    isHoverListProject.value = value;
    selectedIndexProject.value = index;
  }

  showProjectDetail(String projectId) {
    Get.to(
      () => ResponsiveLayout(
        mobileScaffold: MobileProjectDetail(
          projectId: projectId,
          onProjectClosing: () => _onCloseProject(projectId),
        ),
        tabletScaffold: TabletProjectDetail(
          projectId: projectId,
          onProjectClosing: () => _onCloseProject(projectId),
        ),
        desktopScaffold: WebProjectDetail(
          projectId: projectId,
          onProjectClosing: () => _onCloseProject(projectId),
        ),
      ),
    );
  }

  _onCloseProject(String projectId) {
    Get.dialog(
      AlertDialog(
        title: const CustomText("Close Project"),
        content: const CustomText(
          "Are you sure you want to close this project? This action cannot be undone.",
        ),
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
              _closeProject(projectId);
            },
            text: "Close",
            color: AssetColor.redButton,
          ),
        ],
      ),
    );
  }

  _closeProject(String projectId) async {
    isLoading.value = true;

    bool isClosed = await _projectRepo.updateProjectStatus(
        projectId, ProjectStatusType.closing.name);

    if (isClosed) {
      Get.back();
      await _getAllProjects();
      Helpers().showSuccessSnackBar("Project closed successfully");
    } else {
      Helpers().showErrorSnackBar("Close project failed");
    }

    isLoading.value = false;
  }
}
