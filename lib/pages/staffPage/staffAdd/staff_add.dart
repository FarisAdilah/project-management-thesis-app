import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffAdd/controller_staff_add.dart';

class StaffAdd extends StatelessWidget {
  const StaffAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StaffAddController());

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                const Text(
                  "Create Form",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    hintText: "input name",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "input email",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: controller.roleController,
                  decoration: const InputDecoration(
                    labelText: "Role",
                    hintText: "input role",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: controller.phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    hintText: "input phone number",
                  ),
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
                    controller.onImageButtonPressed(ImageSource.gallery,
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
                        Text(
                          "Upload Image",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // TextField(
                //   readOnly: true,
                //   controller: imageController,
                //   decoration: const InputDecoration(
                //     labelText: "Image",
                //     hintText: "image url",
                //   ),
                //   onTap: onTap,
                // ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.createUser();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
