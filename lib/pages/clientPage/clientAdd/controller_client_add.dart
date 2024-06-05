import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/pic/add_pic.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/firebaseModel/client_firebase.dart';
import 'package:project_management_thesis_app/repository/pic/firebaseModel/pic_firebase.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ClientAddController extends GetxController {
  RxBool isLoading = false.obs;

  // Client Controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  Rx<PicFirebase> pic = PicFirebase().obs;

  final ImagePicker _picker = ImagePicker();
  Rx<File> pickedImage = File("").obs;
  Rx<Uint8List> pickedImageWeb = Uint8List(0).obs;

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

  createClient() async {
    isLoading.value = true;

    ClientFirebase client = ClientFirebase();
    client.address = addressController.text;
    client.description = descriptionController.text;
    client.email = emailController.text;
    client.name = nameController.text;
    client.phoneNumber = phoneNumberController.text;
    client.pic = pic.value;

    bool isSuccess = await ClientRepository().createClient(
      client,
      image: pickedImage.value,
      imageWeb: pickedImageWeb.value,
    );

    if (isSuccess) {
      Get.back();
      await Helpers().showSuccessSnackBar("Client created successfully");
    } else {
      Helpers().showErrorSnackBar("Failed to create client");
    }

    isLoading.value = false;
  }
}
