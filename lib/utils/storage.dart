import 'package:get_storage/get_storage.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

mixin Storage {
  static GetStorage get _storage => GetStorage();

  setUserData(UserDM user) {
    _storage.write(StorageType.user.name, user.toJson());
  }

  UserDM? getUserData() {
    var user = _storage.read(StorageType.user.name);
    return UserDM.fromJson(user);
  }
}
