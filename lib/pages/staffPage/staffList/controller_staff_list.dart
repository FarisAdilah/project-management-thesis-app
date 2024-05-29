import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StaffListController extends GetxController {
  RxString imageUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    _getImage();
  }

  _getImage() async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child("images/facebook-profile.jpg");
    String url = await ref.getDownloadURL();
    imageUrl.value = url;
  }
}
