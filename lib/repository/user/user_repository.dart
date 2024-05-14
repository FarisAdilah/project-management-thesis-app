import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/user/abstract/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/admin/admin_dm.dart';
import 'package:project_management_thesis_app/repository/user/projectManager/project_manager_dm.dart';
import 'package:project_management_thesis_app/repository/user/staff/staff_dm.dart';
import 'package:project_management_thesis_app/repository/user/supervisor/dataModel/supervisor_dm.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find<UserRepository>();

  final _db = FirebaseFirestore.instance;

  createUser(UserDM user) async {
    UserDM? newUser;
    if (user.role == UserType.supervisor.name) {
      newUser = SupervisorDM();
    } else if (user.role == UserType.admin.name) {
      newUser = AdminDM();
    } else if (user.role == UserType.projectManager.name) {
      newUser = ProjectManagerDM();
    } else if (user.role == UserType.staff.name) {
      newUser = StaffDM();
    }

    newUser?.name = user.name;
    newUser?.email = user.email;
    newUser?.password = user.password;
    newUser?.role = user.role;
    newUser?.phoneNumber = user.phoneNumber;
    newUser?.image = user.image;

    await _db
        .collection(CollectionType.users.name)
        .add(newUser?.toJson() ?? {})
        .whenComplete(
          () => Helpers().showSuccessSnackBar(
            "Your account has been created successfully!",
          ),
        )
        .catchError(
          (error) => Helpers().showErrorSnackBar(
            "Failed to create user: $error",
          ),
        );
  }
}
