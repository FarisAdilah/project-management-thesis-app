import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/project_repository.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

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
      var data = await _projectRepo.getMultipleProjects(
        user.id ?? "",
        ProjectFieldType.userId,
      );
      if (data.isNotEmpty) {
        projects.value = data;
      }
      var pmProject = await _projectRepo.getMultipleProjects(
        user.id ?? "",
        ProjectFieldType.pmId,
      );
      if (pmProject.isNotEmpty) {
        projects.addAll(pmProject);
      }
    }

    isLoading.value = false;
  }
}
