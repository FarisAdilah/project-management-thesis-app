import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/client/select_client.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/vendor/select_vendor.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class AddPaymentController extends GetxController {
  // final _paymentRepo = PaymentRepository.instance;
  final _clientRepo = ClientRepository.instance;

  RxBool isLoading = false.obs;

  final String projectId;

  AddPaymentController({required this.projectId});

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController vendorController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  DateTime? deadline;
  Rx<VendorDM> selectedVendor = VendorDM().obs;
  Rx<ClientDM> selectedClient = ClientDM().obs;

  @override
  void onInit() async {
    super.onInit();
    await getClient();
  }

  getClient() async {
    isLoading.value = true;
    var clients = await _clientRepo.getMultipleClientByProject(projectId);
    Helpers.writeLog("clients: ${clients.length}");
    if (clients.isNotEmpty) {
      selectedClient.value = clients.first;
    }
    clientController.text = selectedClient.value.name ?? "";
    isLoading.value = false;
  }

  createPayment() async {
    // TODO: ADD CREATE PAYMENT
  }

  selectDatePicker(
    BuildContext context,
    TextEditingController dateController,
  ) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: deadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      dateController.text =
          Helpers().convertDateStringFormat(selectedDate.toString());
      deadline = selectedDate;
    }
  }

  selectClient() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AssetColor.whiteBackground,
        content: SelectClient(
          initialClient: selectedClient.value,
          onClientSelected: (client) {
            selectedClient.value = client;
            clientController.text = client.name ?? "";
          },
        ),
      ),
    );
  }

  selectVendor() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AssetColor.whiteBackground,
        content: SelectVendor(
          projectId: projectId,
          onVendorSelected: (vendor) {
            // TODO: ADD SELECTED VENDOR
          },
          initialVendor: selectedVendor.value,
        ),
      ),
    );
  }
}
