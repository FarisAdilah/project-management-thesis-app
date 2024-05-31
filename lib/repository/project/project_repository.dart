import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/firebaseModel/project_firebase.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class ProjectRepository with RepoBase {
  static ProjectRepository get instance => ProjectRepository();

  getAllProjects() async {
    List collection = await getDataCollection(CollectionType.projects.name);

    List<ProjectFirebase> projectList = [];

    for (var element in collection) {
      ProjectFirebase project = ProjectFirebase.fromFirestore(element);
      projectList.add(project);
    }

    List<ProjectDM> projectDMList = [];

    for (var element in projectList) {
      ProjectDM projectDM = ProjectDM();
      projectDM.id = element.id;
      projectDM.client = element.client;
      projectDM.description = element.description;
      projectDM.endDate = element.endDate;
      projectDM.name = element.name;
      projectDM.payment = element.payment;
      projectDM.startDate = element.startDate;
      projectDM.status = element.status;
      projectDM.timeline = element.timeline;
      projectDM.vendor = element.vendor;

      projectDMList.add(projectDM);
    }

    return projectDMList;
  }
}
