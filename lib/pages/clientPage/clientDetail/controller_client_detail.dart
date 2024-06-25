import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/project_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class ClientDetailController extends GetxController with Storage {
  final _projectRepo = ProjectRepository.instance;

  ClientDM client;

  ClientDetailController({required this.client});

  RxBool isLoading = false.obs;
  RxList<ProjectDM> projects = <ProjectDM>[].obs;

  UserDM? currentUser;

  @override
  void onInit() async {
    super.onInit();

    isLoading.value = true;

    currentUser = await getUserData();

    if (client.projectId?.isNotEmpty ?? false) {
      var projectData = await _projectRepo.getMultipleProjects(
        client.id ?? "",
        ProjectFieldType.clientId,
      );
      if (projectData.isNotEmpty) {
        projects.value = projectData;
      }
    }
    Helpers.writeLog("projects: ${projects.toJson()}");

    isLoading.value = false;
  }
}
