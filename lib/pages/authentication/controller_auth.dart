import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/authentication/authenticaton_repository.dart';
import 'package:project_management_thesis_app/repository/authentication/dataModel/login_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login() async {
    LoginDM creds = LoginDM();
    creds.email = emailController.text;
    creds.password = passwordController.text;

    UserDM? user = await AuthenticationRepository().login(creds);

    if (user != null) {
      emailController.text = "";
      passwordController.text = "";
      Get.offAllNamed("/");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
