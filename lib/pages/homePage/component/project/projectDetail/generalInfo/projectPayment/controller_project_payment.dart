import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ProjectPaymentController extends GetxController {
  RxBool isLoading = false.obs;

  Rx<PaymentDM> selectedPayment = PaymentDM().obs;

  Rx<UserDM> currentUser = UserDM().obs;

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

  setSelectedPayment(PaymentDM payment) {
    if (selectedPayment.value == payment) {
      selectedPayment.value = PaymentDM();
    } else {
      selectedPayment.value = payment;
    }
  }

  viewPaymentFile() {
    Uri fileUrl = Uri.parse(selectedPayment.value.file ?? "");

    Helpers().launchViaUrl(fileUrl);

    // Platform specific code to handle file opening

    // if (kIsWeb) {
    // } else {
    //   // File file = File.fromUri(fileUrl);
    // }
  }
}
