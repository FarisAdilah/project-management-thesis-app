import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class ClientDetail extends StatelessWidget {
  final ClientDM client;
  final VoidCallback onPressed;

  const ClientDetail({
    super.key,
    required this.client,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
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
                          client.image?.isNotEmpty ?? false
                              ? Image.network(
                                  client.image ?? "",
                                  height: 90,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(),
                          client.image?.isNotEmpty ?? false
                              ? const SizedBox(width: 25)
                              : const SizedBox(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  client.name ?? "name",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  client.address ?? "address",
                                  fontSize: 16,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.envelope,
                                          color: AssetColor.grey,
                                          size: 32,
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
                                              client.email ?? "email",
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
                                          size: 32,
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
                                              client.phoneNumber ?? "phone",
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
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.xmark),
                      onPressed: onPressed,
                    ),
                  ],
                ),
                // const SizedBox(height: 5),
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
                  client.description ?? "description",
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
                  client.pic?.name ?? "name",
                ),
                const SizedBox(height: 10),
                const CustomText(
                  "Role",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 8),
                CustomText(
                  client.pic?.role ?? "role",
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
                          size: 32,
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
                              client.pic?.email ?? "email",
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
                          size: 32,
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
                              client.pic?.phoneNumber ?? "phone",
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
        ),
      ),
    );
  }
}
