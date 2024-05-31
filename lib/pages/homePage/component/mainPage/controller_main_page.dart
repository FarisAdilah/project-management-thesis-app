import 'dart:convert';

import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/authentication/authenticaton_repository.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/project_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class MainPageController extends GetxController {
  final _auth = AuthenticationRepository.instance;
  final _userRepo = UserRepository.instance;
  final _vendorRepo = VendorRepository.instance;
  final _clientRepo = ClientRepository.instance;
  final _projectRepo = ProjectRepository.instance;

  RxList<UserDM> users = <UserDM>[].obs;
  RxList<VendorDM> vendors = <VendorDM>[].obs;
  RxList<ClientDM> clients = <ClientDM>[].obs;
  RxList<ProjectDM> projects = <ProjectDM>[].obs;
  Rx<UserDM> currentUser = UserDM().obs;

  @override
  void onInit() async {
    super.onInit();
    await _getAllUser();
    await _getAllVendors();
    await _getAllClients();
    await _getAllProjects();
    await _getCurrentUser();
  }

  _getCurrentUser() async {
    var user = await _auth.user.first;
    UserDM? userDM = user;
    for (var element in users) {
      if (element.email == userDM?.email) {
        userDM = element;
        break;
      }
    }
    Helpers.writeLog("userDM: ${jsonEncode(userDM)}");
    currentUser.value = userDM ?? UserDM();
  }

  _getAllUser() async {
    users.value = await _userRepo.getAllUser();
  }

  _getAllVendors() async {
    vendors.value = await _vendorRepo.getAllVendor();
  }

  _getAllClients() async {
    clients.value = await _clientRepo.getAllClient();
  }

  _getAllProjects() async {
    projects.value = await _projectRepo.getAllProjects();
  }
}
