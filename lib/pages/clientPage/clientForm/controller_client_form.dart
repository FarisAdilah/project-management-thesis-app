import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/pic/mobile_add_pic.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/pic/tablet_add_pic.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/pic/web_add_pic.dart';
import 'package:project_management_thesis_app/pages/responsive_layout.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/client/firebaseModel/client_firebase.dart';
import 'package:project_management_thesis_app/repository/pic/firebaseModel/pic_firebase.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ClientFormController extends GetxController {
  final _clientRepo = ClientRepository.instance;

  RxBool isLoading = false.obs;

  // Client Controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  Rx<PicFirebase> pic = PicFirebase().obs;

  final ClientDM? clientToUpdate;

  ClientFormController({
    this.clientToUpdate,
  });

  final ImagePicker _picker = ImagePicker();
  Rx<File> pickedImage = File("").obs;
  Rx<Uint8List> pickedImageWeb = Uint8List(0).obs;

  @override
  void onInit() {
    super.onInit();

    Helpers.writeLog("clientToUpdate: ${clientToUpdate?.toJson()}");

    if (clientToUpdate != null) {
      nameController.text = clientToUpdate?.name ?? "";
      emailController.text = clientToUpdate?.email ?? "";
      descriptionController.text = clientToUpdate?.description ?? "";
      phoneNumberController.text = clientToUpdate?.phoneNumber ?? "";
      addressController.text = clientToUpdate?.address ?? "";

      PicFirebase picFirebase = PicFirebase();
      picFirebase.name = clientToUpdate?.pic?.name ?? "";
      picFirebase.email = clientToUpdate?.pic?.email ?? "";
      picFirebase.phoneNumber = clientToUpdate?.pic?.phoneNumber ?? "";
      picFirebase.role = clientToUpdate?.pic?.role ?? "";

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
      ResponsiveLayout(
        mobileScaffold: AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: MobileAddPic(
            onAddPic: (value) {
              pic.value = value;
              Helpers.writeLog("pic: ${pic.value.name}");
            },
          ),
        ),
        tabletScaffold: AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: TabletAddPic(
            onAddPic: (value) {
              pic.value = value;
              Helpers.writeLog("pic: ${pic.value.name}");
            },
          ),
        ),
        desktopScaffold: AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: WebAddPic(
            onAddPic: (value) {
              pic.value = value;
              Helpers.writeLog("pic: ${pic.value.name}");
            },
          ),
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
    client.image = "";
    client.projectId = [];

    bool isSuccess = await _clientRepo.createClient(
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

  updateClient() async {
    isLoading.value = true;

    ClientFirebase client = ClientFirebase();
    client.id = clientToUpdate?.id;
    client.address = addressController.text;
    client.description = descriptionController.text;
    client.email = emailController.text;
    client.name = nameController.text;
    client.phoneNumber = phoneNumberController.text;
    client.image = clientToUpdate?.image ?? "";
    client.projectId = clientToUpdate?.projectId ?? [];
    client.pic = pic.value;

    bool isSuccess = await _clientRepo.updateClient(
      client,
      image: pickedImage.value,
      imageWeb: pickedImageWeb.value,
    );

    if (isSuccess) {
      Get.back();
      await Helpers().showSuccessSnackBar("Client updated successfully");
    } else {
      Helpers().showErrorSnackBar("Failed to update client");
    }

    isLoading.value = false;
  }
}
