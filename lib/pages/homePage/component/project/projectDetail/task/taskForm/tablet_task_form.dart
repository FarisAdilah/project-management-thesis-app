import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/background/gradation_background.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/inputCustom/custom_input.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/task/taskForm/controller_task_form.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/dataModel/schedule_task_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/asset_images.dart';

class TabletTaskForm extends StatelessWidget {
  final String timelineId;
  final bool isEdit;
  final ScheduleTaskDM? task;
  final List<UserDM> staffList;

  const TabletTaskForm({
    super.key,
    required this.timelineId,
    required this.staffList,
    this.isEdit = false,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TaskFormController(
      timelineId: timelineId,
      projectStaff: staffList,
      isEdit: isEdit,
      task: task,
    ));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AssetColor.whitePrimary,
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            const GradationBackground(),
            Container(
              margin: const EdgeInsets.all(100),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AssetColor.whitePrimary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                CustomText(
                                  isEdit ? "Task Update" : "Task Registration",
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  isEdit
                                      ? "Update your project Task"
                                      : "register new Task project",
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                            controller: controller.nameController,
                            title: "Task Name",
                            hintText: "input Task name",
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                              controller: controller.startDateController,
                              title: "Start Date",
                              hintText: "input start date",
                              suffixIcon: FontAwesomeIcons.calendar,
                              isPopupInput: true,
                              onTap: () => controller.selectDatePicker(
                                    context,
                                    controller.startDateController,
                                  )),
                          const SizedBox(height: 20),
                          CustomInput(
                              controller: controller.endDateController,
                              title: "End Date",
                              hintText: "input end date",
                              suffixIcon: FontAwesomeIcons.calendar,
                              isPopupInput: true,
                              onTap: () => controller.selectDatePicker(
                                    context,
                                    controller.endDateController,
                                  )),
                          const SizedBox(height: 20),
                          CustomInput(
                            controller: controller.staffController,
                            title: "Staff",
                            isPopupInput: true,
                            onTap: () => controller.selectStaff(),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: CustomButton(
                              onPressed: () {
                                if (isEdit) {
                                  controller.updateTask();
                                } else {
                                  controller.createTask();
                                }
                              },
                              text: isEdit ? "Update Task" : "Create New Task",
                              color: AssetColor.greenButton,
                              textColor: AssetColor.whiteBackground,
                              borderRadius: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        AssetImages.backgroundCreateProject,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  )
                ],
              ),
            ),
            controller.isLoading.value ? const Loading() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
