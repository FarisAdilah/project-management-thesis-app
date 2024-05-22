import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class UserRepository extends GetxController with RepoBase {
  static UserRepository get instance => Get.find<UserRepository>();

  createUser(UserDM user) async {
    await createData(CollectionType.users.name, user.toJson());
  }
}
