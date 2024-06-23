import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/avatar/profile_picture.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/card/mobile_count_card.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/controller_main_page.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/subComponent/mobile_project_content.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class MobileMainPage extends StatelessWidget {
  const MobileMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainPageController());

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Container(
              height: double.infinity,
              color: AssetColor.greyBackground,
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header (Welcom, Search Bar, Profile Picture)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => CustomText(
                                    "Welcome, ${controller.currentUser.value.name ?? ''}!",
                                    fontSize: 24,
                                    color: AssetColor.blueSecondaryAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const CustomText(
                                  "Let's manage your project here",
                                  fontSize: 20,
                                  color: AssetColor.blueTertiaryAccent,
                                ),
                              ],
                            ),
                            Obx(
                              () => ProfilePicture(
                                user: controller.currentUser.value,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SearchBar(
                          leading: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: AssetColor.blueTertiaryAccent,
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                              AssetColor.whiteBackground),
                          surfaceTintColor: WidgetStatePropertyAll(
                              AssetColor.whiteBackground),
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          ),
                          hintText: "Search your project here...",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // General Summary
                    const CustomText(
                      "General Summary",
                      color: AssetColor.blueTertiaryAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: MobileCountCard(
                                  title: "Staff",
                                  countItem: controller.users.length,
                                  icon: FontAwesomeIcons.users,
                                  margin: const EdgeInsets.only(bottom: 20),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: MobileCountCard(
                                  countItem: controller.projects.length,
                                  title: "Project",
                                  icon: FontAwesomeIcons.solidFolderOpen,
                                  margin: const EdgeInsets.only(bottom: 20),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: MobileCountCard(
                                  countItem: controller.vendors.length,
                                  title: "Vendor",
                                  icon: FontAwesomeIcons.userGear,
                                  margin: const EdgeInsets.only(bottom: 20),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: MobileCountCard(
                                  countItem: controller.clients.length,
                                  title: "Client",
                                  icon: FontAwesomeIcons.userTie,
                                  margin: const EdgeInsets.only(bottom: 20),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    controller.getPendingWidget(),
                    const CustomText(
                      "List Project",
                      color: AssetColor.blueTertiaryAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.currentUser.value.role == UserType.admin.name
                        ? CustomButton(
                            text: "Add New Project",
                            color: AssetColor.greenButton,
                            borderRadius: 8,
                            onPressed: () {
                              controller.createProject();
                            },
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => ListView.builder(
                        itemCount: controller.projects.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          ProjectDM project = controller.projects[index];

                          return InkWell(
                            onTap: () => controller.showProjectDetail(
                              project.id ?? "",
                            ),
                            child: MobileProjectContent(
                              project: project,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            controller.isLoading.value ? const Loading() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

Widget _buildRow(
  String name,
  String client,
  String startDate,
  String endDate,
  String status, {
  bool? isTitle,
}) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: _buildCell(name, isTitle: isTitle),
      ),
      Expanded(
        flex: 2,
        child: _buildCell(client, isTitle: isTitle),
      ),
      Expanded(
        flex: 1,
        child: _buildCell(startDate, isTitle: isTitle),
      ),
      Expanded(
        flex: 1,
        child: _buildCell(endDate, isTitle: isTitle),
      ),
      Expanded(
        flex: 1,
        child: _buildCell(status, isTitle: isTitle, isStatus: true),
      ),
    ],
  );
}

Widget _buildCell(
  String title, {
  bool? isTitle,
  bool? isStatus,
}) {
  return (isStatus ?? false) && !(isTitle ?? false)
      ? _buildStatus(title)
      : CustomText(
          title,
          color: isTitle ?? false ? AssetColor.grey : AssetColor.blackPrimary,
          fontSize: 20,
        );
}

Widget _buildStatus(String status) {
  Color statusColor;
  String title = "";
  if (status == ProjectStatusType.pending.name) {
    statusColor = AssetColor.orange;
    title = "Pending";
  } else if (status == ProjectStatusType.rejected.name) {
    statusColor = AssetColor.redButton;
    title = "Rejected";
  } else if (status == ProjectStatusType.ongoing.name) {
    statusColor = AssetColor.blueSecondaryAccent;
    title = "Ongoing";
  } else if (status == ProjectStatusType.closing.name) {
    statusColor = AssetColor.orange;
    title = "Closing";
  } else {
    statusColor = AssetColor.green;
    title = "Completed";
  }

  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: statusColor,
            width: 1,
          ),
        ),
        child: CustomText(
          title,
          color: statusColor,
          fontSize: 20,
        ),
      ),
    ],
  );
}
