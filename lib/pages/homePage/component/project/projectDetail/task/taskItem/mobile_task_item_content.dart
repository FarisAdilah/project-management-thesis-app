import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/avatar/profile_picture.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/dataModel/schedule_task_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class MobileTaskItemContent extends StatelessWidget {
  final List<ScheduleTaskDM> taskList;
  final UserDM staff;
  final ScheduleTaskDM? selectedTask;
  final Function(ScheduleTaskDM) onSelectTask;
  final Function(ScheduleTaskDM) onEditTask;
  final Function(ScheduleTaskDM) onDeleteTask;

  const MobileTaskItemContent({
    super.key,
    required this.taskList,
    required this.staff,
    this.selectedTask,
    required this.onSelectTask,
    required this.onEditTask,
    required this.onDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 30,
                child: ProfilePicture(
                  user: staff,
                ),
              ),
              const SizedBox(width: 15),
              CustomText(
                staff.name ?? "Staff Name",
                fontSize: 16,
                color: AssetColor.blackPrimary,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 5),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              ScheduleTaskDM task = taskList[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => onSelectTask(task),
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 12,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AssetColor.whiteBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedTask?.id == task.id
                              ? AssetColor.green
                              : AssetColor.greyBackground,
                        ),
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
                          CustomText(
                            task.name ?? "Task Name",
                            fontSize: 14,
                            color: AssetColor.blackPrimary,
                          ),
                          CustomText(
                            task.id ?? "Task ID",
                            fontSize: 12,
                            color: AssetColor.grey,
                          ),
                          const Divider(
                            color: AssetColor.grey,
                            thickness: 1,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      "Start Date",
                                      fontSize: 14,
                                      color: AssetColor.grey,
                                    ),
                                    const SizedBox(height: 5),
                                    CustomText(
                                      Helpers().convertDateStringFormat(
                                        task.startDate ?? "Task Name",
                                      ),
                                      fontSize: 14,
                                      color: AssetColor.blackPrimary,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      "End Date",
                                      fontSize: 14,
                                      color: AssetColor.grey,
                                    ),
                                    const SizedBox(height: 5),
                                    CustomText(
                                      Helpers().convertDateStringFormat(
                                        task.endDate ?? "Task Name",
                                      ),
                                      fontSize: 14,
                                      color: AssetColor.blackPrimary,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                "Status",
                                fontSize: 14,
                                color: AssetColor.grey,
                              ),
                              const SizedBox(height: 5),
                              CustomText(
                                Helpers().getTaskStatus(task.status ?? ""),
                                fontSize: 14,
                                color: AssetColor.blackPrimary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  selectedTask?.id == task.id
                      ? Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  text: "Edit",
                                  borderRadius: 8,
                                  color: AssetColor.orangeButton,
                                  onPressed: () => onEditTask(task),
                                ),
                                const SizedBox(width: 10),
                                CustomButton(
                                  text: "Delete",
                                  borderRadius: 8,
                                  color: AssetColor.redButton,
                                  onPressed: () => onDeleteTask(task),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                      : const SizedBox(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
