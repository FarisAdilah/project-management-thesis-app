import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class VendorDetail extends StatelessWidget {
  final VendorDM vendor;
  final VoidCallback onPressed;

  const VendorDetail({
    super.key,
    required this.vendor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Helpers.writeLog("vendor: ${vendor.name} ${vendor.email}");
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AssetColor.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.15,
            horizontal: MediaQuery.sizeOf(context).height * 0.30,
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AssetColor.whiteBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              vendor.image?.isNotEmpty ?? false
                                  ? Image.network(
                                      vendor.image ?? "",
                                      height: 90,
                                      fit: BoxFit.cover,
                                    )
                                  : const SizedBox(),
                              vendor.image?.isNotEmpty ?? false
                                  ? const SizedBox(width: 25)
                                  : const SizedBox(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Row(
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
                                        const SizedBox(width: 25),
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
                                                  vendor.phoneNumber ?? "phone",
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
                    Row(
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
                        const SizedBox(width: 25),
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
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(FontAwesomeIcons.xmark),
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
