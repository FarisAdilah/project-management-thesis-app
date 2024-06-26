import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class MobileClientVendorProject extends StatelessWidget {
  final ClientDM client;
  final List<VendorDM> vendors;

  const MobileClientVendorProject({
    super.key,
    required this.client,
    required this.vendors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              "Client & PIC",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: AssetColor.greyBackground.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      client.image != null
                          ? Expanded(
                              flex: 1,
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              client.address ?? "address",
                              fontSize: 16,
                            ),
                            CustomText(
                              client.phoneNumber ?? "email",
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Center(
                    child: Divider(
                      color: AssetColor.blackPrimary,
                      thickness: 1,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        client.pic?.name ?? "PIC Name",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        client.pic?.role ?? "PIC Role",
                        fontSize: 16,
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.envelope,
                            size: 16,
                          ),
                          const SizedBox(width: 10),
                          CustomText(
                            client.pic?.email ?? "PIC Email",
                            fontSize: 16,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.phone,
                            size: 16,
                          ),
                          const SizedBox(width: 10),
                          CustomText(
                            client.pic?.phoneNumber ?? "PIC Phone",
                            fontSize: 16,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const CustomText(
              "Vendor & PIC List",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: vendors.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                VendorDM vendor = vendors[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: AssetColor.greyBackground.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vendor.image != null
                              ? Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    vendor.image!,
                                    height: 90,
                                  ),
                                )
                              : const SizedBox(),
                          vendor.image != null
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
                                  vendor.name ?? "Vendor Name",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  vendor.address ?? "address",
                                  fontSize: 16,
                                ),
                                CustomText(
                                  vendor.phoneNumber ?? "email",
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Center(
                        child: Divider(
                          color: AssetColor.blackPrimary,
                          thickness: 1,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            vendor.pic?.name ?? "PIC Name",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            vendor.pic?.role ?? "PIC Role",
                            fontSize: 16,
                          ),
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.envelope,
                                size: 16,
                              ),
                              const SizedBox(width: 10),
                              CustomText(
                                vendor.pic?.email ?? "PIC Email",
                                fontSize: 16,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.phone,
                                size: 16,
                              ),
                              const SizedBox(width: 10),
                              CustomText(
                                vendor.pic?.phoneNumber ?? "PIC Phone",
                                fontSize: 16,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
