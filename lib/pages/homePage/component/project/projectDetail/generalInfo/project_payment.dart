import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/controller_project_payment.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class PaymentProject extends StatelessWidget {
  final String projectId;
  final List<PaymentDM> payments;
  final Function(PaymentDM) onCreatePayment;

  const PaymentProject({
    super.key,
    required this.projectId,
    required this.payments,
    required this.onCreatePayment,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProjectPaymentController(
      projectId: projectId,
    ));

    return Obx(
      () => Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: AssetColor.whiteBackground,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AssetColor.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomText(
                      "Payment List",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(width: 20),
                    CustomButton(
                      text: "Add Payment",
                      borderRadius: 8,
                      color: AssetColor.greenButton,
                      textColor: AssetColor.whiteBackground,
                      onPressed: () {
                        controller.addNewPayment();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      PaymentDM payment = payments[index];
                      controller.setVendor(payment.vendorId ?? "");

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AssetColor.whiteBackground,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AssetColor.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                    "ID",
                                    color: AssetColor.grey,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomText(
                                    payment.id ?? "payment ID",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                    "Name",
                                    color: AssetColor.grey,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomText(
                                    payment.paymentName ?? "payment name",
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      "Client Name",
                                      color: AssetColor.grey,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomText(
                                      controller.projectClient.value.name ??
                                          "payment name",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Obx(
                              () => Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      "Vendor Name",
                                      color: AssetColor.grey,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomText(
                                      controller.currentVendor.value.name ??
                                          "-",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                    "Amount",
                                    color: AssetColor.grey,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomText(
                                    Helpers().currencyFormat(
                                        payment.paymentAmount ?? "0"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                    "Status",
                                    color: AssetColor.grey,
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller
                                          .getPaymentStatusColor(
                                            payment.status ?? "",
                                          )
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: controller.getPaymentStatusColor(
                                          payment.status ?? "",
                                        ),
                                      ),
                                    ),
                                    child: CustomText(
                                      payment.status?.capitalizeFirst ??
                                          "payment status",
                                      color: controller.getPaymentStatusColor(
                                        payment.status ?? "",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Column(
                              children: [
                                CustomText(
                                  "Preview",
                                  color: AssetColor.grey,
                                ),
                                SizedBox(height: 10),
                                Icon(
                                  FontAwesomeIcons.solidFilePdf,
                                  applyTextScaling: true,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          controller.isLoading.value ? const Loading() : const SizedBox(),
        ],
      ),
    );
  }
}
