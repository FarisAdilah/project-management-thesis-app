import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/authentication/authenticaton_repository.dart';
import 'package:project_management_thesis_app/repository/authentication/dataModel/login_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/response/user_response.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class UserRepository extends GetxController with RepoBase {
  static UserRepository get instance => Get.find<UserRepository>();

  createUser(UserDM user, LoginDM currentUser) async {
    if (user.email != null && user.password != null) {
      final result =
          await registerWithEmailAndPassword(user.email!, user.password!);
      Helpers().writeLog("result: $result");
      await createData(CollectionType.users.name, user.toJson());

      AuthenticationRepository().login(currentUser);
    } else {
      Helpers().showErrorSnackBar("Email and Password is not valid");
    }
  }

  Future<List<UserDM>> getAllUser() async {
    List collection = await getDataCollection(CollectionType.users.name);

    List<UserDataResponse> userDataresponseList = [];

    for (var element in collection) {
      UserDataResponse userDataResponse =
          UserDataResponse.fromFirestore(element);
      userDataresponseList.add(userDataResponse);
    }

    List<UserDM> userList = [];

    for (var element in userDataresponseList) {
      UserDM user = UserDM();
      user.id = element.id;
      user.email = element.email;
      user.name = element.name;
      user.role = element.role;
      user.image = element.image;
      user.password = element.password;
      user.phoneNumber = element.phoneNumber;

      userList.add(user);
    }

    return userList;
  }
}
