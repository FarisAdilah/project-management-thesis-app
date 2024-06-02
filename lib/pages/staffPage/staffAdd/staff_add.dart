import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/globalComponent/background/gradation_background.dart';
import 'package:project_management_thesis_app/globalComponent/inputCustom/custom_input.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffAdd/controller_staff_add.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/asset_images.dart';

class StaffAdd extends StatelessWidget {
  const StaffAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StaffAddController());

    return Scaffold(
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
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: SingleChildScrollView(
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                "Register Your Staff",
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomInput(
                                title: "Name",
                                controller: controller.nameController,
                                hintText: "input name",
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInput(
                                title: "Email",
                                controller: controller.emailController,
                                hintText: "input email",
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const CustomText(
                                "Role",
                                color: AssetColor.blackPrimary,
                                fontSize: 16,
                              ),
                              DropdownButtonFormField(
                                hint: CustomText(
                                  "select role",
                                  color: AssetColor.grey.withOpacity(0.5),
                                  fontSize: 16,
                                ),
                                value: controller.roleController.text.isEmpty
                                    ? null
                                    : controller.roleController.text,
                                items: [
                                  for (var item in controller.role)
                                    DropdownMenuItem(
                                      value: item,
                                      child: CustomText(item),
                                    ),
                                ],
                                onChanged: (value) {
                                  controller.roleController.text =
                                      value.toString();
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInput(
                                title: "Phone Number",
                                controller: controller.phoneNumberController,
                                hintText: "input phone number",
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              controller.pickedImage.value.path.isNotEmpty ||
                                      controller.pickedImageWeb.value.isNotEmpty
                                  ? kIsWeb
                                      ? Image.memory(
                                          controller.pickedImageWeb.value,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.file(
                                          controller.pickedImage.value,
                                          fit: BoxFit.fill,
                                        )
                                  : const SizedBox(),
                              const SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  controller.onImageButtonPressed(
                                      ImageSource.gallery,
                                      context: context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(FontAwesomeIcons.upload),
                                      SizedBox(width: 10),
                                      CustomText(
                                        "Upload Image",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.createUser();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.blue,
                                    ),
                                  ),
                                  child: const CustomText(
                                    "Submit",
                                    color: AssetColor.whitePrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        right: 4,
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Image.asset(
                          AssetImages.backgroundCreateUser,
                          fit: BoxFit.cover,
                          alignment: Alignment.bottomCenter,
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
