import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffDetail/controller_staff_detail.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class WebStaffDetail extends StatelessWidget {
  final UserDM user;

  const WebStaffDetail({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StaffDetailController(user: user));

    return Obx(
      () => Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.5,
            width: MediaQuery.sizeOf(context).width * 0.4,
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
                                user.image?.isNotEmpty ?? false
                                    ? Image.network(
                                        user.image ?? "",
                                        height: 90,
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox(),
                                user.image?.isNotEmpty ?? false
                                    ? const SizedBox(width: 25)
                                    : const SizedBox(),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        user.name ?? "name",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        user.id ?? "id",
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
                                                    user.email ?? "email",
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
                                                    user.phoneNumber ?? "phone",
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
                        "General Information",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      const CustomText(
                        "Role",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        Helpers().getUserRole(user.role ?? "role"),
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
                                  "This Staff has no project related yet.",
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
                                          margin:
                                              const EdgeInsets.only(right: 10),
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
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.xmark),
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
          ),
          controller.isLoading.value
              ? Loading(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  width: MediaQuery.sizeOf(context).width * 0.4,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
