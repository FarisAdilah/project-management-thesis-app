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
import 'package:project_management_thesis_app/pages/vendorPage/vendorAdd/controller_vendor_add.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/asset_images.dart';

class VendorAdd extends StatelessWidget {
  const VendorAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorAddController());

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
                              const Center(
                                child: CustomText(
                                  "Vendor Registration",
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              const Center(
                                child: CustomText(
                                  "Register your vendor data",
                                  fontSize: 16,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomInput(
                                title: "Vendor Name",
                                controller: controller.nameController,
                                hintText: "input vendor name",
                                inputType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInput(
                                title: "Vendor Email",
                                controller: controller.emailController,
                                hintText: "input vendor email",
                                inputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInput(
                                title: "Vendor Phone Number",
                                controller: controller.phoneNumberController,
                                hintText: "input vendor phone number",
                                inputType: TextInputType.phone,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInput(
                                title: "Vendor Description",
                                controller: controller.descriptionController,
                                hintText: "input vendor description",
                                inputType: TextInputType.multiline,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInput(
                                title: "Vendor Address",
                                controller: controller.addressController,
                                hintText: "input vendor address",
                                inputType: TextInputType.streetAddress,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const CustomText(
                                "Vendor Image",
                                color: AssetColor.blackPrimary,
                                fontSize: 16,
                              ),
                              SizedBox(
                                height: controller.pickedImage.value.path
                                            .isNotEmpty ||
                                        controller
                                            .pickedImageWeb.value.isNotEmpty
                                    ? 15
                                    : 0,
                              ),
                              controller.pickedImage.value.path.isNotEmpty ||
                                      controller.pickedImageWeb.value.isNotEmpty
                                  ? kIsWeb
                                      ? Image.memory(
                                          controller.pickedImageWeb.value,
                                          fit: BoxFit.cover,
                                          height: 100,
                                        )
                                      : Image.file(
                                          controller.pickedImage.value,
                                          fit: BoxFit.cover,
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
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
                                                    .isNotEmpty
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                    "Vendor PIC",
                                    color: AssetColor.blackPrimary,
                                    fontSize: 16,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  controller.pic.value.name?.isNotEmpty ?? false
                                      ? Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: AssetColor
                                                    .bluePrimaryAccent,
                                                border: Border.all(
                                                  color: AssetColor
                                                      .blueSecondaryAccent,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    controller.pic.value.name!,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  const SizedBox(width: 20),
                                                  InkWell(
                                                    onTap: () {
                                                      controller.clearPic();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
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
                                        )
                                      : CustomButton(
                                          onPressed: () {
                                            controller.addPic();
                                          },
                                          color: AssetColor.orangeButton,
                                          text: "Add PIC",
                                          textColor: AssetColor.whitePrimary,
                                          borderRadius: 5,
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: CustomButton(
                                  onPressed: () {
                                    controller.createVendor();
                                  },
                                  color: AssetColor.greenButton,
                                  text: "Create New Vendor",
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
                        AssetImages.backgroundCreateExternal,
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
