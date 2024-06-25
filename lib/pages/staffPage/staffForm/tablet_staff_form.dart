import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/globalComponent/background/gradation_background.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/inputCustom/custom_input.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffForm/controller_staff_form.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/asset_images.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class TabletStaffForm extends StatelessWidget {
  final UserDM? userDM;
  final bool isUpdate;

  const TabletStaffForm({
    super.key,
    this.userDM,
    this.isUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StaffFormController(userToUpdate: userDM));

    Helpers.writeLog("image web: ${controller.pickedImageWeb.value}");
    Helpers.writeLog("image mobile: ${controller.pickedImage.value.path}");

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
                              Center(
                                child: CustomText(
                                  isUpdate
                                      ? "Update Your Staff"
                                      : "Register Your Staff",
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                height: 15,
                              ),
                              const CustomText(
                                "Image User",
                                color: AssetColor.blackPrimary,
                                fontSize: 16,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              (controller.userToUpdate?.image?.isNotEmpty ??
                                          false) &&
                                      controller
                                          .pickedImage.value.path.isEmpty &&
                                      controller.pickedImageWeb.value.isEmpty
                                  ? Image.network(
                                      controller.userToUpdate?.image ?? "",
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    )
                                  : kIsWeb
                                      ? controller
                                              .pickedImageWeb.value.isNotEmpty
                                          ? Image.memory(
                                              controller.pickedImageWeb.value,
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                            )
                                          : const SizedBox()
                                      : controller
                                              .pickedImage.value.path.isNotEmpty
                                          ? Image.file(
                                              controller.pickedImage.value,
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(FontAwesomeIcons.upload),
                                      const SizedBox(width: 10),
                                      CustomText(
                                        controller.pickedImage.value.path
                                                    .isNotEmpty ||
                                                controller.pickedImageWeb.value
                                                    .isNotEmpty ||
                                                (controller.userToUpdate?.image
                                                        ?.isNotEmpty ??
                                                    false)
                                            ? "Reupload Image"
                                            : "Upload Image",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              !isUpdate
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            AssetColor.orange.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AssetColor.orange),
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.circleInfo,
                                            applyTextScaling: true,
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text.rich(
                                              TextSpan(
                                                text:
                                                    "Your user password will be generated automatically by format: ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      AssetColor.blackPrimary,
                                                  fontFamily: ("Jost"),
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: "<First Name>#123",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AssetColor
                                                          .blackPrimary,
                                                      fontFamily: ("Jost"),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: CustomButton(
                                  onPressed: () {
                                    if (isUpdate) {
                                      controller.updateUser();
                                    } else {
                                      controller.createUser();
                                    }
                                  },
                                  color: AssetColor.greenButton,
                                  text: isUpdate
                                      ? "Update User"
                                      : "Create New User",
                                  textColor: AssetColor.whitePrimary,
                                  borderRadius: 10,
                                ),
                              ),
                            ],
                          ),
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
                        AssetImages.backgroundCreateUser,
                        fit: BoxFit.cover,
                        height: double.infinity,
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
