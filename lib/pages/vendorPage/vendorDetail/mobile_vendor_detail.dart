import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/vendorPage/vendorDetail/controller_vendor_detail.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class MobileVendorDetail extends StatelessWidget {
  final VendorDM vendor;
  final VoidCallback onClose;
  final Function(VendorDM) onEditVendor;
  final Function(VendorDM) onDeleteVendor;

  const MobileVendorDetail({
    super.key,
    required this.vendor,
    required this.onClose,
    required this.onEditVendor,
    required this.onDeleteVendor,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorDetailController(vendor: vendor));

    return Obx(
      () => Stack(
        children: [
          Container(
            // height: MediaQuery.sizeOf(context).height * 0.6,
            width: MediaQuery.sizeOf(context).width * 0.9,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AssetColor.whiteBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  vendor.image?.isNotEmpty ?? false
                                      ? Image.network(
                                          vendor.image ?? "",
                                          height: 90,
                                          fit: BoxFit.cover,
                                        )
                                      : const SizedBox(),
                                  vendor.image?.isNotEmpty ?? false
                                      ? const SizedBox(height: 10)
                                      : const SizedBox(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        vendor.name ?? "name",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        vendor.address ?? "address",
                                        fontSize: 16,
                                      ),
                                      const SizedBox(height: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.envelope,
                                                color: AssetColor.grey,
                                                size: 28,
                                                applyTextScaling: true,
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const CustomText(
                                                    "Email",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  CustomText(
                                                    vendor.email ?? "email",
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.phone,
                                                color: AssetColor.grey,
                                                applyTextScaling: true,
                                                size: 25,
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const CustomText(
                                                    "Phone Number",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  CustomText(
                                                    vendor.phoneNumber ??
                                                        "phone",
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: AssetColor.grey,
                          thickness: 1,
                        ),
                        const SizedBox(height: 5),
                        const CustomText(
                          "Description",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          vendor.description ?? "description",
                          fontSize: 16,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              "Projects",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 10),
                            controller.projects.isEmpty
                                ? const CustomText(
                                    "This Vendor has no project related yet.",
                                  )
                                : Obx(
                                    () => SizedBox(
                                      height: 40,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.projects.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          ProjectDM project =
                                              controller.projects[index];

                                          return Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AssetColor.greyBackground,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: CustomText(
                                              project.name ?? "name",
                                              fontSize: 16,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        const CustomText(
                          "Person In Charge",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 10),
                        const CustomText(
                          "Name",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          vendor.pic?.name ?? "name",
                        ),
                        const SizedBox(height: 10),
                        const CustomText(
                          "Role",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          vendor.pic?.role ?? "role",
                        ),
                        const SizedBox(height: 10),
                        const CustomText(
                          "Contact Information",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.envelope,
                                  color: AssetColor.grey,
                                  size: 28,
                                  applyTextScaling: true,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      "Email",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      vendor.pic?.email ?? "email",
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.phone,
                                  color: AssetColor.grey,
                                  applyTextScaling: true,
                                  size: 25,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      "Phone Number",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      vendor.pic?.phoneNumber ?? "phone",
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        controller.currentUser?.role == UserType.admin.name
                            ? const SizedBox(height: 10)
                            : const SizedBox(),
                        controller.currentUser?.role == UserType.admin.name
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomButton(
                                    text: "Edit",
                                    textColor: AssetColor.whiteBackground,
                                    borderRadius: 10,
                                    color: AssetColor.orangeButton,
                                    onPressed: () => onEditVendor(vendor),
                                  ),
                                  const SizedBox(width: 10),
                                  CustomButton(
                                    text: "Delete",
                                    textColor: AssetColor.whiteBackground,
                                    borderRadius: 10,
                                    color: AssetColor.redButton,
                                    onPressed: () => onDeleteVendor(vendor),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.xmark),
                    onPressed: onClose,
                  ),
                ),
              ],
            ),
          ),
          controller.isLoading.value
              ? Loading(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  width: MediaQuery.sizeOf(context).width * 0.5,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
