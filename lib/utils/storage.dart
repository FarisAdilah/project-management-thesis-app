import 'package:get_storage/get_storage.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

mixin Storage {
  static GetStorage get _storage => GetStorage();

  Future<void> setUserData(UserDM user) async {
    await _storage.write(StorageType.user.name, user.toJson());
  }

  Future<UserDM?> getUserData() async {
    var user = _storage.read(StorageType.user.name);
    if (user != null) {
      return UserDM.fromJson(user);
    } else {
      return null;
    }
  }
}
