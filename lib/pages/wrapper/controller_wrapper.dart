import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/authentication/authenticaton_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';

class WrapperController extends GetxController {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  Stream<UserDM?> get user => _authenticationRepository.user;
}
