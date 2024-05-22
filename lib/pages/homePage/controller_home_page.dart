import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/authentication/authenticaton_repository.dart';

class HomePageController extends GetxController {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  logout() async {
    await _authenticationRepository.logout();
    Get.offAllNamed("/");
  }
}
