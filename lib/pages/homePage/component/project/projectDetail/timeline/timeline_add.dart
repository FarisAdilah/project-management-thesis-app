import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/background/gradation_background.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/inputCustom/custom_input.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/timeline/controller_timeline_add.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/asset_images.dart';

class AddTimeline extends StatelessWidget {
  final String projectId;

  const AddTimeline({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTimelineController(
      projectId: projectId,
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
                          const Center(
                            child: Column(
                              children: [
                                CustomText(
                                  "Timeline Registration",
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  "register new timeline project",
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                            controller: controller.nameController,
                            title: "Timeline Name",
                            hintText: "input timeline name",
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
                          Center(
                            child: CustomButton(
                              onPressed: () {
                                controller.createTimeline();
                              },
                              text: "Create New Timeline",
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
                        AssetImages.backgroundCreateTimeline,
                        fit: BoxFit.cover,
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
