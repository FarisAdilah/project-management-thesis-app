import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/pic/add_pic.dart';
import 'package:project_management_thesis_app/repository/pic/firebaseModel/pic_firebase.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/firebaseModel/vendor_firebase.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class VendorFormController extends GetxController {
  final _vendorRepo = VendorRepository.instance;

  RxBool isLoading = false.obs;

  // Vendor Controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final imageController = TextEditingController();

  Rx<PicFirebase> pic = PicFirebase().obs;

  final VendorDM? vendorToUpdate;

  VendorFormController({
    this.vendorToUpdate,
  });

  final ImagePicker _picker = ImagePicker();
  Rx<File> pickedImage = File("").obs;
  Rx<Uint8List> pickedImageWeb = Uint8List(0).obs;

  @override
  void onInit() {
    super.onInit();

    Helpers.writeLog("vendorToUpdate: ${vendorToUpdate?.toJson()}");

    if (vendorToUpdate != null) {
      nameController.text = vendorToUpdate?.name ?? "";
      emailController.text = vendorToUpdate?.email ?? "";
      descriptionController.text = vendorToUpdate?.description ?? "";
      phoneNumberController.text = vendorToUpdate?.phoneNumber ?? "";
      addressController.text = vendorToUpdate?.address ?? "";
      imageController.text = vendorToUpdate?.image ?? "";

      PicFirebase picFirebase = PicFirebase();
      picFirebase.name = vendorToUpdate?.pic?.name ?? "";
      picFirebase.email = vendorToUpdate?.pic?.email ?? "";
      picFirebase.phoneNumber = vendorToUpdate?.pic?.phoneNumber ?? "";
      picFirebase.role = vendorToUpdate?.pic?.role ?? "";

      pic.value = picFirebase;
    }
  }

  Future<void> onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    XFile? pickedFile = await _picker.pickImage(source: source);

    isLoading.value = true;

    if (pickedFile != null) {
      if (kIsWeb) {
        Helpers.writeLog("helloooo kIsWeb: $kIsWeb");
        var image = await pickedFile.readAsBytes();
        pickedImageWeb.value = image;
      } else {
        var image = File(pickedFile.path);
        pickedImage.value = image;
      }
    } else {
      Helpers.writeLog("No image selected.");
    }

    isLoading.value = false;
  }

  addPic() {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(
          vertical: 150,
          horizontal: 300,
        ),
        child: AddPic(
          onAddPic: (value) {
            pic.value = value;
            Helpers.writeLog("pic: ${pic.value.name}");
          },
        ),
      ),
    );
  }

  clearPic() {
    pic.value = PicFirebase();
  }

  createVendor() async {
    isLoading.value = true;

    VendorFirebase vendor = VendorFirebase();
    vendor.address = addressController.text;
    vendor.description = descriptionController.text;
    vendor.email = emailController.text;
    vendor.name = nameController.text;
    vendor.phoneNumber = phoneNumberController.text;
    vendor.pic = pic.value;
    vendor.image = "";
    vendor.projectId = [];

    bool isSuccess = await _vendorRepo.createVendor(
      vendor,
      image: pickedImage.value,
      imageWeb: pickedImageWeb.value,
    );

    if (isSuccess) {
      Get.back();
      await Helpers().showSuccessSnackBar("Vendor created successfully");
    } else {
      Helpers().showErrorSnackBar("Failed to create vendor");
    }

    isLoading.value = false;
  }

  updateVendor() async {
    isLoading.value = true;

    VendorFirebase vendor = VendorFirebase();
    vendor.id = vendorToUpdate?.id;
    vendor.address = addressController.text;
    vendor.description = descriptionController.text;
    vendor.email = emailController.text;
    vendor.name = nameController.text;
    vendor.phoneNumber = phoneNumberController.text;
    vendor.image = vendorToUpdate?.image;
    vendor.projectId = vendorToUpdate?.projectId;
    vendor.pic = pic.value;

    bool isSuccess = await _vendorRepo.updateVendor(
      vendor,
      image: pickedImage.value,
      imageWeb: pickedImageWeb.value,
    );

    if (isSuccess) {
      Get.back();
      Helpers.writeLog("Vendor updated successfully");
      Helpers().showSuccessSnackBar("Vendor updated successfully");
    } else {
      Helpers().showErrorSnackBar("Failed to update vendor");
    }

    isLoading.value = false;
  }
}
