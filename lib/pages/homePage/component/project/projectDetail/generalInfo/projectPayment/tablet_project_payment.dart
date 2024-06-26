import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/projectPayment/controller_project_payment.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class TabletPaymentProject extends StatelessWidget {
  final List<PaymentDM> payments;
  final ClientDM client;
  final List<VendorDM> vendors;
  final VoidCallback onCreatePayment;
  final Function(PaymentDM) onEditPayment;
  final Function(PaymentDM) onDeletePayment;
  final UserDM currentUser;

  const TabletPaymentProject({
    super.key,
    required this.payments,
    required this.onCreatePayment,
    required this.client,
    required this.vendors,
    required this.currentUser,
    required this.onEditPayment,
    required this.onDeletePayment,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProjectPaymentController());

    Helpers.writeLog("currentUser: ${currentUser.toJson()}");

    return Container(
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
              currentUser.role == UserType.projectManager.name
                  ? CustomButton(
                      text: "Add Payment",
                      borderRadius: 8,
                      color: AssetColor.greenButton,
                      textColor: AssetColor.whiteBackground,
                      onPressed: onCreatePayment,
                    )
                  : const SizedBox(),
              const Spacer(),
              Obx(
                () {
                  if (controller.selectedPayment.value.id == null) {
                    return const SizedBox();
                  }
                  if (controller.selectedPayment.value.status ==
                      PaymentStatusType.approved.name) {
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
                  } else if (controller.selectedPayment.value.status ==
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
                              onEditPayment(
                                controller.selectedPayment.value,
                              );
                              controller.setSelectedPayment(PaymentDM());
                            }),
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
                              onDeletePayment(
                                controller.selectedPayment.value,
                              );
                              controller.setSelectedPayment(PaymentDM());
                            }),
                      ],
                    );
                  } else {
                    return const CustomText(
                      "This payment is still pending",
                      color: AssetColor.grey,
                      fontSize: 16,
                    );
                  }
                },
              )
            ],
          ),
          const SizedBox(height: 20),
          payments.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: AssetColor.whiteBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: CustomText(
                      "There's no Payment yet",
                      color: AssetColor.blackPrimary.withOpacity(0.5),
                      fontSize: 20,
                    ),
                  ),
                )
              : SizedBox(
                  height: 500,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      final payment = payments[index];
                      // controller.setVendor(payment.vendorId ?? "");
                      final vendor = vendors.firstWhere(
                        (vendor) => vendor.id == payment.vendorId,
                        orElse: () => VendorDM(),
                      );

                      return InkWell(
                        onTap: () {
                          controller.setSelectedPayment(payment);
                        },
                        child: Obx(
                          () => Container(
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
                              border: Border.all(
                                color: controller.selectedPayment.value.id ==
                                        payment.id
                                    ? AssetColor.greenButton
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                        "Client Name",
                                        color: AssetColor.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      CustomText(
                                        client.name ?? "payment name",
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                        "Vendor Name",
                                        color: AssetColor.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      CustomText(
                                        vendor.name ?? "-",
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: controller
                                                .getPaymentStatusColor(
                                              payment.status ?? "",
                                            ),
                                          ),
                                        ),
                                        child: CustomText(
                                          payment.status?.capitalizeFirst ??
                                              "payment status",
                                          color:
                                              controller.getPaymentStatusColor(
                                            payment.status ?? "",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
