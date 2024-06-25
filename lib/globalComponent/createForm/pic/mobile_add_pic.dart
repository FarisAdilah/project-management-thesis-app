import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/inputCustom/custom_input.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/pic/controller_add_pic.dart';
import 'package:project_management_thesis_app/repository/pic/firebaseModel/pic_firebase.dart';

class MobileAddPic extends StatelessWidget {
  final Function(PicFirebase) onAddPic;

  const MobileAddPic({
    super.key,
    required this.onAddPic,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddPicController());

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          const CustomText(
            "Add New PIC",
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 25),
          CustomInput(
            title: "Name",
            controller: controller.nameController,
          ),
          const SizedBox(height: 10),
          CustomInput(
            title: "Email",
            controller: controller.emailController,
          ),
          const SizedBox(height: 10),
          CustomInput(
            title: "Phone Number",
            controller: controller.phoneNumberController,
          ),
          const SizedBox(height: 10),
          CustomInput(
            title: "Role",
            controller: controller.roleController,
          ),
          const Spacer(),
          CustomButton(
            onPressed: () {
              onAddPic(controller.setPicData());
              Get.back();
            },
            text: "Add New Pic",
          ),
        ],
      ),
    );
  }
}
