import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/background/gradation_background.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/inputCustom/custom_input.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectForm/controller_project_form.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class MobileProjectForm extends StatelessWidget {
  final bool isEdit;
  final ProjectDM? project;

  const MobileProjectForm({
    super.key,
    this.isEdit = false,
    this.project,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProjectFormController(
      isEdit: isEdit,
      project: project,
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
              margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AssetColor.whitePrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  CustomText(
                                    isEdit
                                        ? "Project Revision"
                                        : "Project Registration",
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomText(
                                    isEdit
                                        ? "Revise your project data"
                                        : "register your project data",
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
                            const CustomText(
                              "Client",
                              color: AssetColor.blackPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            controller.chosenClient.value.id == null
                                ? CustomButton(
                                    onPressed: () => controller.selectClient(),
                                    text: "Select Client",
                                    color: AssetColor.blueSecondaryAccent,
                                    textColor: AssetColor.whiteBackground,
                                    borderRadius: 8,
                                  )
                                : Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AssetColor.bluePrimaryAccent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color:
                                                AssetColor.blueSecondaryAccent,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            CustomText(
                                              controller.chosenClient.value
                                                      .name ??
                                                  "",
                                              fontSize: 18,
                                            ),
                                            const SizedBox(width: 20),
                                            InkWell(
                                              onTap: () {
                                                controller.removeClient();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                child: const Icon(
                                                  FontAwesomeIcons.xmark,
                                                  color: Colors.red,
                                                  size: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 15,
                            ),
                            const CustomText(
                              "Vendor List",
                              color: AssetColor.blackPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            controller.selectedVendor.isEmpty
                                ? const CustomText(
                                    "No vendor selected",
                                    color: AssetColor.grey,
                                    fontSize: 16,
                                  )
                                : Column(
                                    children: controller.selectedVendor
                                        .map(
                                          (vendor) => Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: 5,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AssetColor
                                                      .bluePrimaryAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: AssetColor
                                                        .blueSecondaryAccent,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText(
                                                      vendor.name ?? "",
                                                      fontSize: 18,
                                                    ),
                                                    const SizedBox(width: 20),
                                                    InkWell(
                                                      onTap: () {
                                                        controller.removeVendor(
                                                            vendor);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          border: Border.all(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        child: const Icon(
                                                          FontAwesomeIcons
                                                              .xmark,
                                                          color: Colors.red,
                                                          size: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomButton(
                              onPressed: () => controller.selectVendor(),
                              text: "Add Vendor",
                              color: AssetColor.blueSecondaryAccent,
                              textColor: AssetColor.whiteBackground,
                              borderRadius: 8,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const CustomText(
                              "Project Manager",
                              color: AssetColor.blackPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            controller.chosenProjectManager.value.id == null
                                ? CustomButton(
                                    onPressed: () =>
                                        controller.selectProjectManager(),
                                    text: "Select Project Manager",
                                    color: AssetColor.blueSecondaryAccent,
                                    textColor: AssetColor.whiteBackground,
                                    borderRadius: 8,
                                  )
                                : Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AssetColor.bluePrimaryAccent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color:
                                                AssetColor.blueSecondaryAccent,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            CustomText(
                                              controller.chosenProjectManager
                                                      .value.name ??
                                                  "",
                                              fontSize: 18,
                                            ),
                                            const SizedBox(width: 20),
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .removeProjectManager();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                child: const Icon(
                                                  FontAwesomeIcons.xmark,
                                                  color: Colors.red,
                                                  size: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: CustomButton(
                                onPressed: () => {
                                  isEdit
                                      ? controller.reviseProject()
                                      : controller.createProject(),
                                },
                                text: isEdit
                                    ? "Revise Project"
                                    : "Create New Project",
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
