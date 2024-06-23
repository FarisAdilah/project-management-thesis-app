import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/background/gradation_background.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/inputCustom/custom_input.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/payment/controller_payment_form.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/asset_images.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class PaymentForm extends StatelessWidget {
  final String projectId;
  final List<VendorDM> vendorList;
  final bool isEdit;
  final PaymentDM? payment;

  const PaymentForm({
    super.key,
    required this.projectId,
    required this.vendorList,
    this.isEdit = false,
    this.payment,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentFormController(
      projectId: projectId,
      availableVendor: vendorList,
      isEdit: isEdit,
      payment: payment,
    ));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AssetColor.whitePrimary,
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            const GradationBackground(),
            Container(
              margin: const EdgeInsets.all(100),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AssetColor.whitePrimary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  CustomText(
                                    isEdit
                                        ? "Payment Update"
                                        : "Payment Registration",
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomText(
                                    isEdit
                                        ? "Update project payment"
                                        : "register new project payment",
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomInput(
                              controller: controller.nameController,
                              title: "Payment Name",
                              hintText: "input payment name",
                            ),
                            const SizedBox(height: 20),
                            CustomInput(
                              controller: controller.clientController,
                              title: "Client Name",
                              hintText: "input client name",
                              inputType: TextInputType.none,
                              readOnly: true,
                              enabled: false,
                            ),
                            const SizedBox(height: 20),
                            CustomInput(
                              controller: controller.vendorController,
                              title: "Vendor Name",
                              hintText: "input vendor name",
                              isPopupInput: true,
                              onTap: () => controller.selectVendor(),
                            ),
                            const SizedBox(height: 20),
                            CustomInput(
                              controller: controller.amountController,
                              title: "Payment Amount",
                              hintText: "input payment amount",
                              onTyping: (amount) {
                                Helpers.writeLog("Amount: $amount");
                                controller.formatAmount(amount);
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomInput(
                              controller: controller.deadlineController,
                              title: "Payment Deadline",
                              hintText: "input payment deadline",
                              isPopupInput: true,
                              suffixIcon: FontAwesomeIcons.calendar,
                              onTap: () => controller.selectDatePicker(
                                context,
                                controller.deadlineController,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: CustomButton(
                                onPressed: () {
                                  if (isEdit) {
                                    controller.updatePayment();
                                  } else {
                                    controller.createPayment();
                                  }
                                },
                                text: isEdit
                                    ? "Update Payment"
                                    : "Create New Payment",
                                color: AssetColor.greenButton,
                                textColor: AssetColor.whiteBackground,
                                borderRadius: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        AssetImages.backgroundCreatePayment,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            controller.isLoading.value ? const Loading() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
