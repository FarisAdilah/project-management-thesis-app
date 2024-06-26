import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/controller_project_detail.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/timeline/timelineItem/tablet_timeline_item_content.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/timeline/dataModel/timeline_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class TabletProjectDetail extends StatelessWidget {
  final String projectId;
  final VoidCallback onProjectClosing;

  const TabletProjectDetail({
    super.key,
    required this.projectId,
    required this.onProjectClosing,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProjectDetailController(projectId: projectId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.1,
                  vertical: 50,
                ),
                decoration: const BoxDecoration(
                  color: AssetColor.greyBackground,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "Project Detail",
                      fontSize: 28,
                      color: AssetColor.blackPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: AssetColor.whiteBackground,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AssetColor.blackPrimary.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Obx(
                        () {
                          ProjectDM project = controller.project.value;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                project.name ?? "Project Name",
                                fontSize: 24,
                                color: AssetColor.blackPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                              const SizedBox(height: 20),
                              CustomText(
                                project.description ?? "Project Description",
                                fontSize: 20,
                                color: AssetColor.blackPrimary,
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      const CustomText(
                                        "Start Date",
                                        fontSize: 20,
                                        color: AssetColor.blackPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AssetColor.orange,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: CustomText(
                                          Helpers().convertDateStringFormat(
                                            project.startDate ?? "2024-04-04",
                                          ),
                                          fontSize: 16,
                                          color: AssetColor.whiteBackground,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  const Icon(FontAwesomeIcons.arrowRight),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      const CustomText(
                                        "End Date",
                                        fontSize: 20,
                                        color: AssetColor.blackPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AssetColor.orange,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: CustomText(
                                          Helpers().convertDateStringFormat(
                                            project.endDate ?? "2024-04-04",
                                          ),
                                          fontSize: 16,
                                          color: AssetColor.whiteBackground,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const CustomText(
                                    "Project Manager: ",
                                    fontSize: 20,
                                    color: AssetColor.blackPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(width: 10),
                                  CustomText(
                                    controller.projectPM.value.name ??
                                        "Project Manager Name",
                                    fontSize: 20,
                                    color: AssetColor.blackPrimary,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const CustomText(
                                    "Status: ",
                                    fontSize: 20,
                                    color: AssetColor.blackPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller
                                          .getStatusColor(
                                            project.status ?? "",
                                          )
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: controller.getStatusColor(
                                          project.status ?? "",
                                        ),
                                      ),
                                    ),
                                    child: CustomText(
                                      project.status?.capitalizeFirst ??
                                          "Status",
                                      fontSize: 20,
                                      color: controller.getStatusColor(
                                        project.status ?? "",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    const CustomText(
                      "General Info",
                      fontSize: 28,
                      color: AssetColor.blackPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    Column(
                      children: [
                        Obx(
                          () => TabBar(
                            controller: controller.tabInfoController,
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            onTap: (value) {
                              controller.updateInfoController(value);
                            },
                            tabs: [
                              for (String title in controller.tabInfoList)
                                Tab(
                                  child: CustomText(
                                    title,
                                    fontSize: 20,
                                    color: AssetColor.blackPrimary,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        controller.getInfoWidget(),
                      ],
                    ),
                    const SizedBox(height: 50),
                    const CustomText(
                      "Timeline",
                      fontSize: 28,
                      color: AssetColor.blackPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    Column(
                      children: [
                        Obx(
                          () => TabBar(
                            controller: controller.tabTimelineController,
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            tabs: [
                              for (String title in controller.tabTimelineList)
                                if (title == "add")
                                  const Tab(
                                    icon: Icon(FontAwesomeIcons.plus),
                                  )
                                else
                                  Tab(
                                    child: CustomText(
                                      title,
                                      fontSize: 20,
                                      color: AssetColor.blackPrimary,
                                    ),
                                  ),
                            ],
                            onTap: (index) {
                              controller.setTimeline(index);
                            },
                          ),
                        ),
                        Container(
                          height: 800,
                          decoration: BoxDecoration(
                            color: AssetColor.whiteBackground,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: AssetColor.blackPrimary.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Obx(
                            () => TabBarView(
                              controller: controller.tabTimelineController,
                              children: controller.tabTimelineList
                                  .map((String title) {
                                Helpers.writeLog("title: $title");

                                if (controller.tabTimelineList.length == 1 &&
                                    title == "add") {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 25,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AssetColor.whiteBackground,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        "There's no Timeline yet",
                                        fontSize: 24,
                                        color: AssetColor.blackPrimary
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  );
                                }

                                TimelineDM timeline =
                                    controller.selectedTimeline.value;
                                return TabletTimelineItemContent(
                                  currentUser:
                                      controller.currentUser ?? UserDM(),
                                  timeline: timeline,
                                  task: controller.task,
                                  editTimeline: () => controller.editTimeline(),
                                  deleteTimeline: () =>
                                      controller.deleteTimeline(),
                                  addTask: () => controller.addTask(),
                                  projectStaff: controller.projectStaff,
                                  selectedTask: controller.selectedTask.value,
                                  onSelectTask: (task) =>
                                      controller.setSelectedTask(task),
                                  onEditTask: (task) =>
                                      controller.editTask(task),
                                  onDeleteTask: (task) =>
                                      controller.deleteTask(task),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AssetColor.orange,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AssetColor.whiteBackground,
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.circleInfo,
                            color: AssetColor.whiteBackground,
                            applyTextScaling: true,
                          ),
                          SizedBox(width: 10),
                          CustomText(
                            "The project can be closed when all tasks and payments are completed",
                            fontSize: 20,
                            color: AssetColor.whiteBackground,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: CustomButton(
                        isEnabled: controller.isButtonCloseEnabled.value,
                        text: "Close Project",
                        onPressed: controller.isButtonCloseEnabled.value
                            ? onProjectClosing
                            : null,
                        color: AssetColor.redButton,
                        disableColor: AssetColor.redButton.withOpacity(0.5),
                        borderRadius: 15,
                        textSize: 20,
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
