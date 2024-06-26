import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/client/web_select_client.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/vendor/mobile_select_vendor.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/vendor/tablet_select_vendor.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/vendor/web_select_vendor.dart';
import 'package:project_management_thesis_app/pages/responsive_layout.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/repository/payment/firebaseModel/payment_firebase.dart';
import 'package:project_management_thesis_app/repository/payment/payment_repository.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class PaymentFormController extends GetxController {
  final _paymentRepo = PaymentRepository.instance;
  final _clientRepo = ClientRepository.instance;
  final _vendorRepo = VendorRepository.instance;

  RxBool isLoading = false.obs;

  final String projectId;
  final List<VendorDM> availableVendor;
  final bool isEdit;
  final PaymentDM? payment;

  PaymentFormController({
    required this.projectId,
    required this.availableVendor,
    this.isEdit = false,
    this.payment,
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

    if (isEdit) {
      Helpers.writeLog("VendorId: ${payment?.vendorId}");
      nameController.text = payment?.paymentName ?? "";
      amountController.text =
          Helpers().currencyFormat(payment?.paymentAmount ?? "");
      deadlineController.text = Helpers().convertDateStringFormat(
        payment?.deadline ?? "",
      );
      deadline = DateTime.parse(payment?.deadline ?? "");
      selectedClient.value =
          await _clientRepo.getClientById(payment?.clientId ?? "");
      clientController.text = selectedClient.value.name ?? "";
      selectedVendor.value =
          await _vendorRepo.getVendorById(payment?.vendorId ?? "");
      vendorController.text = selectedVendor.value.name ?? "";
    }
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
        content: WebSelectClient(
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
      ResponsiveLayout(
        mobileScaffold: AlertDialog(
          backgroundColor: AssetColor.whiteBackground,
          contentPadding: const EdgeInsets.all(0),
          content: MobileSelectVendor(
            projectId: projectId,
            onVendorSelected: (vendor) {
              selectedVendor.value = vendor;
              vendorController.text = vendor.name ?? "vendor name";
            },
            initialVendor: selectedVendor.value,
            availableVendor: availableVendor,
          ),
        ),
        tabletScaffold: AlertDialog(
          backgroundColor: AssetColor.whiteBackground,
          contentPadding: const EdgeInsets.all(0),
          content: TabletSelectVendor(
            projectId: projectId,
            onVendorSelected: (vendor) {
              selectedVendor.value = vendor;
              vendorController.text = vendor.name ?? "vendor name";
            },
            initialVendor: selectedVendor.value,
            availableVendor: availableVendor,
          ),
        ),
        desktopScaffold: AlertDialog(
          backgroundColor: AssetColor.whiteBackground,
          contentPadding: const EdgeInsets.all(0),
          content: WebSelectVendor(
            projectId: projectId,
            onVendorSelected: (vendor) {
              selectedVendor.value = vendor;
              vendorController.text = vendor.name ?? "vendor name";
            },
            initialVendor: selectedVendor.value,
            availableVendor: availableVendor,
          ),
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
    PaymentFirebase param = PaymentFirebase();
    param.id = payment?.id;
    param.amount = amountController.text
        .replaceAll("Rp", "")
        .replaceAll(".", "")
        .replaceAll(",", ".");
    param.clientId = selectedClient.value.id;
    param.deadline = deadline.toString();
    param.name = nameController.text;
    param.projectId = projectId;
    param.status = PaymentStatusType.pending.name;
    param.vendorId = selectedVendor.value.id;
    param.file = "";

    Helpers.writeLog("Payment Param: ${param.toFirestore()}");

    bool isUpdated = await _paymentRepo.updatePayment(param);

    if (isUpdated) {
      Get.back(result: true);
    } else {
      Helpers().showErrorSnackBar("Failed to update payment, please try again");
    }
  }
}
