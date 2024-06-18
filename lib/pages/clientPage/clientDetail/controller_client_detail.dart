import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/project_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ClientDetailController extends GetxController {
  final _projectRepo = ProjectRepository.instance;

  ClientDM client;

  ClientDetailController({required this.client});

  RxBool isLoading = false.obs;
  RxList<ProjectDM> projects = <ProjectDM>[].obs;

  @override
  void onInit() async {
    super.onInit();

    isLoading.value = true;

    if (client.projectId?.isNotEmpty ?? false) {
      for (var projectId in client.projectId ?? []) {
        var data = await _projectRepo.getProjectById(projectId);
        if (data != null) {
          projects.add(data);
        }
      }
    }
    Helpers.writeLog("projects: ${projects.toJson()}");

    isLoading.value = false;
  }
}
