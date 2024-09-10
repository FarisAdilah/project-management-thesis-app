import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/avatar/profile_picture.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/card/web_count_card.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/controller_main_page.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class WebMainPage extends StatelessWidget {
  const WebMainPage({
    super.key,
  });

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => CustomText(
                                  "Welcome, ${controller.currentUser.value.name ?? ''}!",
                                  fontSize: 30,
                                  color: AssetColor.blueSecondaryAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const CustomText(
                                "Let's manage your project here",
                                fontSize: 20,
                                color: AssetColor.blueTertiaryAccent,
                              )
                            ],
                          ),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: SearchBar(
                              leading: Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: AssetColor.blueTertiaryAccent,
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                  AssetColor.whiteBackground),
                              surfaceTintColor: WidgetStatePropertyAll(
                                  AssetColor.whiteBackground),
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                              ),
                              hintText: "Search your project here...",
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Obx(
                              () => ProfilePicture(
                                user: controller.currentUser.value,
                              ),
                            ),
                          ),
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
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: WebCountCard(
                              title: "Total Staff",
                              countItem: controller.users.length,
                              icon: FontAwesomeIcons.users,
                              margin: const EdgeInsets.only(right: 20),
                            ),
                          ),
                          Expanded(
                            child: WebCountCard(
                              countItem: controller.projects.length,
                              title: "Total Project",
                              icon: FontAwesomeIcons.solidFolderOpen,
                              margin: const EdgeInsets.only(right: 20),
                            ),
                          ),
                          Expanded(
                            child: WebCountCard(
                              countItem: controller.vendors.length,
                              title: "Total Vendor",
                              icon: FontAwesomeIcons.userGear,
                              margin: const EdgeInsets.only(right: 20),
                            ),
                          ),
                          Expanded(
                            child: WebCountCard(
                              countItem: controller.clients.length,
                              title: "Total Client",
                              icon: FontAwesomeIcons.userTie,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    controller.getPendingWidget(),
                    controller.getPendingPayment(),
                    controller.getClosingWidget(),
                    const CustomText(
                      "List Project",
                      color: AssetColor.blueTertiaryAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: AssetColor.whiteBackground,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: AssetColor.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
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
                                "All Projects",
                                color: AssetColor.blackPrimary,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              controller.currentUser.value.role ==
                                      UserType.admin.name
                                  ? const SizedBox(width: 20)
                                  : const SizedBox(),
                              controller.currentUser.value.role ==
                                      UserType.admin.name
                                  ? CustomButton(
                                      text: "Add New Project",
                                      color: AssetColor.greenButton,
                                      borderRadius: 8,
                                      onPressed: () {
                                        controller.createProject();
                                      },
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _buildRow(
                            "Project Name",
                            "Client",
                            "Start Date",
                            "End Date",
                            "Status",
                            isTitle: true,
                          ),
                          Obx(
                            () => ListView.builder(
                              itemCount: controller.projects.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                ProjectDM project = controller.projects[index];

                                return InkWell(
                                  onTap: () => controller.showProjectDetail(
                                    project.id ?? "",
                                  ),
                                  onHover: (value) =>
                                      controller.setHoverValue(value, index),
                                  child: Obx(
                                    () => AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          color: controller.isHoverListProject
                                                      .value &&
                                                  controller
                                                          .selectedIndexProject
                                                          .value ==
                                                      index
                                              ? AssetColor.greyBackground
                                              : AssetColor.whiteBackground,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: AssetColor.grey
                                                  .withOpacity(0.5),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: _buildRow(
                                          project.name ?? "",
                                          project.clientName ?? "",
                                          Helpers().convertDateStringFormat(
                                            project.startDate ?? "2024-04-04",
                                          ),
                                          Helpers().convertDateStringFormat(
                                            project.endDate ?? "2024-04-04",
                                          ),
                                          project.status ?? "",
                                        )),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
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
    statusColor = AssetColor.grey;
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
  } else if (status == ProjectStatusType.pendingClose.name) {
    statusColor = AssetColor.orangeButton;
    title = "Pending Close";
  } else if (status == ProjectStatusType.rejectClose.name) {
    statusColor = AssetColor.redButton;
    title = "Rejected Close";
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
