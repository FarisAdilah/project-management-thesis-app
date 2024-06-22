import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/client/select_client.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/vendor/select_vendor.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/payment/firebaseModel/payment_firebase.dart';
import 'package:project_management_thesis_app/repository/payment/payment_repository.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class AddPaymentController extends GetxController {
  final _paymentRepo = PaymentRepository.instance;
  final _clientRepo = ClientRepository.instance;

  RxBool isLoading = false.obs;

  final String projectId;

  AddPaymentController({
    required this.projectId,
  });

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController vendorController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  DateTime? deadline;
  Rx<VendorDM> selectedVendor = VendorDM().obs;
  Rx<ClientDM> selectedClient = ClientDM().obs;
  RxList<VendorDM> vendorList = <VendorDM>[].obs;

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
            selectedVendor.value = vendor;
            vendorController.text = vendor.name ?? "vendor name";
          },
          initialVendor: selectedVendor.value,
        ),
      ),
    );
  }

  formatAmount(String amount) {
    Helpers.writeLog("Amount: $amount");
    if (amount.isNotEmpty) {
      amountController.text = Helpers().currencyFormat(
        amount.replaceAll("Rp", "").replaceAll(".", "").replaceAll(",", "."),
      );
      Helpers.writeLog("AmountController: ${amountController.text}");
      amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: amountController.text.length),
      );
    }
  }

  createPayment() async {
    PaymentFirebase param = PaymentFirebase();
    String amountFormatted = amountController.text
        .replaceAll("Rp", "")
        .replaceAll(".", "")
        .replaceAll(",", ".");
    param.amount = amountFormatted;
    param.clientId = selectedClient.value.id;
    param.deadline = deadline.toString();
    param.name = nameController.text;
    param.projectId = projectId;
    param.status = PaymentStatusType.pending.name;
    param.vendorId = selectedVendor.value.id;
    param.file = "";

    Helpers.writeLog("Payment Param: ${param.toFirestore()}");

    String paymentId = await _paymentRepo.createPayment(param);

    if (paymentId.isNotEmpty) {
      Get.back(result: true);
    } else {
      Helpers().showErrorSnackBar("Failed to create payment, please try again");
    }
  }

  updatePayment() async {
    // TODO: implement updatePayment
  }
}
