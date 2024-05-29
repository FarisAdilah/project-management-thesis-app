import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/authentication/authenticaton_repository.dart';
import 'package:project_management_thesis_app/repository/authentication/dataModel/login_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class AuthController extends GetxController with Storage {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isObscure = true.obs;
  RxBool isLoading = false.obs;
  RxBool enableButton = false.obs;

  login() async {
    isLoading.value = true;
    LoginDM creds = LoginDM();
    creds.email = emailController.text;
    creds.password = passwordController.text;

    UserDM? user = await AuthenticationRepository().login(creds);

    isLoading.value = false;
    if (user != null) {
      emailController.clear();
      passwordController.clear();
      setUserData(user);
      enableButton.value = false;
      Get.offAllNamed("/");
    }
  }

  toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  onTyping() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      enableButton.value = true;
    } else {
      enableButton.value = false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
