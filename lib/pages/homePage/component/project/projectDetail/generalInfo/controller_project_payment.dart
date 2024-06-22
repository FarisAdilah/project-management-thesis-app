import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
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
    getPaymentActions();
  }

  Widget getPaymentActions() {
    Helpers.writeLog(
        "Selected payment: ${jsonEncode(selectedPayment.value.status)}");
    if (selectedPayment.value.id?.isNotEmpty ?? false) {
      if (selectedPayment.value.status == PaymentStatusType.pending.name) {
        return IconButton(
          icon: const Icon(
            FontAwesomeIcons.solidFilePdf,
            applyTextScaling: true,
            color: AssetColor.whiteBackground,
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              AssetColor.purple,
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.all(10),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          onPressed: () {
            // TODO: Implement Preview PDF
          },
        );
      } else if (selectedPayment.value.status ==
          PaymentStatusType.rejected.name) {
        return Row(
          children: [
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.penToSquare,
                applyTextScaling: true,
                color: AssetColor.whiteBackground,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  AssetColor.orangeButton,
                ),
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.all(10),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                // TODO: Implement Edit Payment
              },
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.trashCan,
                applyTextScaling: true,
                color: AssetColor.whiteBackground,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  AssetColor.redButton,
                ),
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.all(10),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                // TODO: Implement Delete Payment
              },
            ),
          ],
        );
      } else {
        return const CustomText(
          "This payment is still pending",
          color: AssetColor.black,
          fontSize: 16,
        );
      }
    } else {
      return const SizedBox();
    }
  }
}
