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
import 'package:project_management_thesis_app/pages/clientPage/clientForm/controller_client_form.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/asset_images.dart';

class WebClientForm extends StatelessWidget {
  final bool isUpdate;
  final ClientDM? client;

  const WebClientForm({
    super.key,
    this.isUpdate = false,
    this.client,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClientFormController(
      clientToUpdate: client,
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
                                      ? "Update Client"
                                      : "Client Registration",
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Center(
                                child: CustomText(
                                  isUpdate
                                      ? "Update your client data"
                                      : "Register your client data",
                                  fontSize: 16,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomInput(
                                title: "Client Name",
                                controller: controller.nameController,
                                hintText: "input client name",
                                inputType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInput(
                                title: "Client Email",
                                controller: controller.emailController,
                                hintText: "input client email",
                                inputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInput(
                                title: "Client Phone Number",
                                controller: controller.phoneNumberController,
                                hintText: "input client phone number",
                                inputType: TextInputType.phone,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInput(
                                title: "Client Description",
                                controller: controller.descriptionController,
                                hintText: "input client description",
                                inputType: TextInputType.multiline,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomInput(
                                title: "Client Address",
                                controller: controller.addressController,
                                hintText: "input client address",
                                inputType: TextInputType.streetAddress,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const CustomText(
                                "Client Image",
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
                              controller.clientToUpdate?.image?.isNotEmpty ??
                                      false
                                  ? Image.network(
                                      controller.clientToUpdate!.image!,
                                      fit: BoxFit.cover,
                                      height: 100,
                                    )
                                  : controller.pickedImage.value.path
                                              .isNotEmpty ||
                                          controller
                                              .pickedImageWeb.value.isNotEmpty
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
                                                    .isNotEmpty ||
                                                (controller.clientToUpdate
                                                        ?.image?.isNotEmpty ??
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                    "Client PIC",
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
                                    if (isUpdate) {
                                      controller.updateClient();
                                    } else {
                                      controller.createClient();
                                    }
                                  },
                                  color: AssetColor.greenButton,
                                  text: isUpdate
                                      ? "Update Client"
                                      : "Create New Client",
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
