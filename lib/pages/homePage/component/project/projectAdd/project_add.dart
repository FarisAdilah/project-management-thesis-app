import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/background/gradation_background.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/inputCustom/custom_input.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectAdd/controller_project_add.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/asset_images.dart';

class AddProject extends StatelessWidget {
  const AddProject({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddProjectController());

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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Column(
                                children: [
                                  CustomText(
                                    "Project Registration",
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomText(
                                    "register your project data",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            CustomInput(
                              title: "Project Name",
                              controller: controller.nameController,
                              hintText: "input project name",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomInput(
                              title: "Project Description",
                              controller: controller.descriptionController,
                              hintText: "input project description",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomInput(
                              title: "Start Date",
                              controller: controller.startDateController,
                              onTap: () => controller.selectDatePicker(
                                context,
                                controller.startDateController,
                              ),
                              isPopupInput: true,
                              suffixIcon: FontAwesomeIcons.calendar,
                              hintText: "yyyy-mm-dd",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomInput(
                              title: "End Date",
                              controller: controller.endDateController,
                              onTap: () => controller.selectDatePicker(
                                context,
                                controller.endDateController,
                              ),
                              isPopupInput: true,
                              suffixIcon: FontAwesomeIcons.calendar,
                              hintText: "yyyy-mm-dd",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomInput(
                              title: "Client",
                              controller: controller.clientController,
                              onTap: () => controller.selectClient(),
                              hintText: "select client",
                              isPopupInput: true,
                              suffixIcon: FontAwesomeIcons.caretDown,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: CustomButton(
                                onPressed: () => {
                                  Get.back(),
                                },
                                text: "Create New Project",
                                color: AssetColor.orangeButton,
                                textColor: AssetColor.whiteBackground,
                                borderRadius: 8,
                              ),
                            )
                          ],
                        ),
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
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            controller.isLoading.value ? const Loading() : const SizedBox()
          ],
        ),
      ),
    );
  }
}
