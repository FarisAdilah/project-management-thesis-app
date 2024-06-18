import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/project_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';

class StaffDetailController extends GetxController {
  final _projectRepo = ProjectRepository.instance;

  UserDM user;

  StaffDetailController({required this.user});

  RxBool isLoading = false.obs;
  RxList<ProjectDM> projects = <ProjectDM>[].obs;

  @override
  void onInit() async {
    super.onInit();

    isLoading.value = true;

    if (user.projectId?.isNotEmpty ?? false) {
      for (var projectId in user.projectId ?? []) {
        var data = await _projectRepo.getProjectById(projectId);
        if (data != null) {
          projects.add(data);
        }
      }
    }

    isLoading.value = false;
  }
}
