import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/pic/firebaseModel/pic_firebase.dart';

class AddPicController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final roleController = TextEditingController();

  PicFirebase setPicData() {
    PicFirebase pic = PicFirebase();
    pic.name = nameController.text;
    pic.email = emailController.text;
    pic.phoneNumber = phoneNumberController.text;
    pic.role = roleController.text;

    return pic;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    roleController.dispose();
    super.onClose();
  }
}
