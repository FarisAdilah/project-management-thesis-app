import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class PendingPaymentDetail extends StatelessWidget {
  final PaymentDM payment;
  final VendorDM vendors;
  final ClientDM client;
  final bool isPm;

  const PendingPaymentDetail({
    super.key,
    required this.payment,
    required this.vendors,
    required this.client,
    this.isPm = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 25,
        bottom: 10,
        top: 10,
      ),
      decoration: BoxDecoration(
        color: AssetColor.whiteBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      height: MediaQuery.sizeOf(context).height * 0.75,
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    payment.paymentName ?? "name",
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    payment.id ?? "id",
                    fontSize: 20,
                    textAlign: TextAlign.justify,
                  ),
                  const Divider(
                    color: AssetColor.grey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                    "Amount",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    Helpers().currencyFormat(
                      payment.paymentAmount ?? "0",
                    ),
                    fontSize: 20,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            "Deadline",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AssetColor.orange,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: CustomText(
                              Helpers().convertDateStringFormat(
                                  payment.deadline ?? ""),
                              color: AssetColor.whiteBackground,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const CustomText(
                    "Client",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: AssetColor.greyBackground.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        client.image != null
                            ? Expanded(
                                child: Image.network(
                                  client.image!,
                                  height: 90,
                                ),
                              )
                            : const SizedBox(),
                        client.image != null
                            ? const SizedBox(
                                width: 15,
                              )
                            : const SizedBox(),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                client.name ?? "Client Name",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                client.address ?? "address",
                                fontSize: 20,
                              ),
                              CustomText(
                                client.phoneNumber ?? "email",
                                fontSize: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                    "Vendor",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: AssetColor.greyBackground.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        vendors.image != null
                            ? Expanded(
                                child: Image.network(
                                  vendors.image!,
                                  height: 90,
                                ),
                              )
                            : const SizedBox(),
                        vendors.image != null
                            ? const SizedBox(
                                width: 15,
                              )
                            : const SizedBox(),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                vendors.name ?? "vendors Name",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                vendors.address ?? "address",
                                fontSize: 20,
                              ),
                              CustomText(
                                vendors.phoneNumber ?? "email",
                                fontSize: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  isPm
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: AssetColor.redButton,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.circleInfo,
                                color: AssetColor.whiteBackground,
                                applyTextScaling: true,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomText(
                                  "This payment has been rejected by Admin. Please delete or edit to Continue.",
                                  color: AssetColor.whiteBackground,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  isPm
                      ? const SizedBox()
                      : CustomButton(
                          text: "Add Document",
                          borderRadius: 8,
                          onPressed: () {},
                        )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(FontAwesomeIcons.xmark),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
