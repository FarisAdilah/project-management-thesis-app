import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientDetail/controller_client_detail.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class MobileClientDetail extends StatelessWidget {
  final ClientDM client;
  final VoidCallback onClose;
  final Function(ClientDM) onEditClient;
  final Function(ClientDM) onDeleteClient;

  const MobileClientDetail({
    super.key,
    required this.client,
    required this.onClose,
    required this.onEditClient,
    required this.onDeleteClient,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClientDetailController(
      client: client,
    ));

    return Obx(
      () => Stack(
        children: [
          Container(
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
                                  client.image?.isNotEmpty ?? false
                                      ? Image.network(
                                          client.image ?? "",
                                          height: 90,
                                          fit: BoxFit.cover,
                                        )
                                      : const SizedBox(),
                                  client.image?.isNotEmpty ?? false
                                      ? const SizedBox(height: 10)
                                      : const SizedBox(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                    client.email ?? "email",
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
                                                    client.phoneNumber ??
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
                          client.description ?? "description",
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
                                    "This Client has no project related yet.",
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
                                      client.pic?.email ?? "email",
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
                                      client.pic?.phoneNumber ?? "phone",
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              text: "Edit",
                              textColor: AssetColor.whiteBackground,
                              borderRadius: 10,
                              color: AssetColor.orangeButton,
                              onPressed: () => onEditClient(client),
                            ),
                            const SizedBox(width: 10),
                            CustomButton(
                              text: "Delete",
                              textColor: AssetColor.whiteBackground,
                              borderRadius: 10,
                              color: AssetColor.redButton,
                              onPressed: () => onDeleteClient(client),
                            ),
                          ],
                        ),
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
