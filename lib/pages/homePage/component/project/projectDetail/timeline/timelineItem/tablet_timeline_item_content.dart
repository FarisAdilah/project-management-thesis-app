import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/task/taskItem/tablet_task_item_content.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/dataModel/schedule_task_dm.dart';
import 'package:project_management_thesis_app/repository/timeline/dataModel/timeline_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class TabletTimelineItemContent extends StatelessWidget {
  final UserDM currentUser;
  final TimelineDM timeline;
  final List<ScheduleTaskDM> task;
  final VoidCallback editTimeline;
  final VoidCallback deleteTimeline;
  final VoidCallback addTask;
  final List<UserDM> projectStaff;
  final ScheduleTaskDM? selectedTask;
  final Function(ScheduleTaskDM) onSelectTask;
  final Function(ScheduleTaskDM) onEditTask;
  final Function(ScheduleTaskDM) onDeleteTask;

  const TabletTimelineItemContent({
    super.key,
    required this.currentUser,
    required this.timeline,
    required this.task,
    required this.editTimeline,
    required this.deleteTimeline,
    required this.addTask,
    required this.projectStaff,
    this.selectedTask,
    required this.onSelectTask,
    required this.onEditTask,
    required this.onDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          currentUser.role == UserType.projectManager.name
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      timeline.name ?? "Timeline Name",
                      fontSize: 24,
                      color: AssetColor.blackPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.penToSquare,
                        color: AssetColor.orangeButton,
                      ),
                      onPressed: editTimeline,
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.trash,
                        color: AssetColor.redButton,
                      ),
                      onPressed: deleteTimeline,
                    ),
                  ],
                )
              : CustomText(
                  timeline.name ?? "Timeline Name",
                  fontSize: 24,
                  color: AssetColor.blackPrimary,
                  fontWeight: FontWeight.bold,
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText(
                      Helpers().convertDateStringFormat(
                        timeline.startDate ?? "2024-04-04",
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText(
                      Helpers().convertDateStringFormat(
                        timeline.endDate ?? "2024-04-04",
                      ),
                      fontSize: 16,
                      color: AssetColor.whiteBackground,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(
            color: AssetColor.grey,
            thickness: 1,
          ),
          const SizedBox(height: 15),
          const CustomText(
            "Task List",
            fontSize: 24,
            color: AssetColor.blackPrimary,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          task.isEmpty
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          "There's no Task yet",
                          fontSize: 24,
                          color: AssetColor.blackPrimary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: "Add Task",
                          onPressed: addTask,
                          color: AssetColor.greenButton,
                          textColor: AssetColor.whiteBackground,
                          borderRadius: 8,
                        )
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 450,
                        child: Obx(
                          () {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemCount: projectStaff.length,
                              itemBuilder: (context, index) {
                                UserDM staff = projectStaff[index];

                                List<ScheduleTaskDM> taskList = task
                                    .where((task) => task.staffId == staff.id)
                                    .toList();

                                if (taskList.isEmpty) {
                                  return const SizedBox();
                                } else {
                                  return TabletTaskItemContent(
                                    taskList: taskList,
                                    staff: staff,
                                    selectedTask: selectedTask,
                                    onSelectTask: (task) => onSelectTask(task),
                                    onEditTask: (task) => onEditTask(task),
                                    onDeleteTask: (task) => onDeleteTask(task),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: CustomButton(
                          text: "Add Task",
                          onPressed: addTask,
                          color: AssetColor.greenButton,
                          textColor: AssetColor.whiteBackground,
                          borderRadius: 8,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
