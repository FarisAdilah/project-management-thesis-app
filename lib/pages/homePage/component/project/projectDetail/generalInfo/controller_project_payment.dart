import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/payment/payment_add.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ProjectPaymentController extends GetxController {
  final _clientRepo = ClientRepository.instance;
  final _vendorRepo = VendorRepository.instance;

  RxBool isLoading = false.obs;
  Rx<ClientDM> projectClient = ClientDM().obs;
  RxList<VendorDM> projectVendor = <VendorDM>[].obs;

  Rx<VendorDM> currentVendor = VendorDM().obs;

  final String projectId;

  ProjectPaymentController({required this.projectId});

  @override
  void onInit() async {
    super.onInit();
    await getProjectClient();
    await getProjectVendor();
  }

  addNewPayment() {
    Get.to(
      () => AddPayment(
        projectId: projectId,
      ),
    );
  }

  getProjectClient() async {
    isLoading.value = true;

    var clientData = await _clientRepo.getMultipleClientByProject(projectId);
    projectClient.value = clientData.first;

    Helpers.writeLog("Client Data: ${projectClient.value.toJson()}");

    isLoading.value = false;
  }

  getProjectVendor() async {
    isLoading.value = true;

    var vendorData = await _vendorRepo.getMultipleVendor(projectId);
    projectVendor.value = vendorData;

    Helpers.writeLog("Vendor Data: ${jsonEncode(projectVendor)}");

    isLoading.value = false;
  }

  setVendor(String vendorId) {
    currentVendor.value = projectVendor.firstWhereOrNull(
          (element) => element.id == vendorId,
        ) ??
        VendorDM();
  }

  Color getPaymentStatusColor(String status) {
    if (status == PaymentStatusType.pending.name) {
      return AssetColor.orange;
    } else if (status == PaymentStatusType.approved.name) {
      return AssetColor.green;
    } else if (status == PaymentStatusType.rejected.name) {
      return AssetColor.redButton;
    } else {
      return AssetColor.grey;
    }
  }
}
