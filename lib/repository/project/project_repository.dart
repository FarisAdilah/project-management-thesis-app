import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/firebaseModel/project_firebase.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ProjectRepository with RepoBase {
  static ProjectRepository get instance => ProjectRepository();

  Future<List<ProjectDM>> getAllProjects() async {
    List collection = await getDataCollection(CollectionType.projects.name);

    List<ProjectFirebase> projectList = [];
    for (var element in collection) {
      ProjectFirebase project = ProjectFirebase.fromFirestoreList(element);
      projectList.add(project);
    }

    List<ProjectDM> projectDMList = [];
    for (var element in projectList) {
      ProjectDM projectDM = ProjectDM();
      projectDM.id = element.id;
      projectDM.description = element.description;
      projectDM.endDate = element.endDate;
      projectDM.name = element.name;
      projectDM.startDate = element.startDate;
      projectDM.status = element.status;
      projectDM.userId = element.userId;
      projectDM.clientId = element.clientId;
      projectDM.vendorId = element.vendorId;
      projectDM.pmId = element.pmId;
      projectDM.file = element.file;
      projectDM.fileName = element.fileName;

      projectDMList.add(projectDM);
    }
    Helpers.writeLog("projectDMList: ${projectDMList.length}");

    return projectDMList;
  }

  Future<List<ProjectDM>> getMultipleProjects(
    String id,
    ProjectFieldType field,
  ) async {
    List collection = await getMultipleDocument(
      CollectionType.projects.name,
      field.name,
      id,
      isArray: field == ProjectFieldType.userId ||
          field == ProjectFieldType.vendorId,
    );

    List<ProjectFirebase> projectList = [];
    for (var element in collection) {
      ProjectFirebase project = ProjectFirebase.fromFirestoreList(element);
      projectList.add(project);
    }

    List<ProjectDM> projectDMList = [];
    for (var element in projectList) {
      ProjectDM projectDM = ProjectDM();
      projectDM.id = element.id;
      projectDM.description = element.description;
      projectDM.endDate = element.endDate;
      projectDM.name = element.name;
      projectDM.startDate = element.startDate;
      projectDM.status = element.status;
      projectDM.userId = element.userId;
      projectDM.clientId = element.clientId;
      projectDM.vendorId = element.vendorId;
      projectDM.pmId = element.pmId;
      projectDM.file = element.file;
      projectDM.fileName = element.fileName;

      projectDMList.add(projectDM);
    }

    return projectDMList;
  }

  Future<ProjectDM?> getProjectById(String id) async {
    var data = await getDataDocument(CollectionType.projects.name, id);
    ProjectFirebase project = ProjectFirebase.fromFirestoreDoc(data);

    ProjectDM projectDM = ProjectDM();
    projectDM.id = project.id;
    projectDM.description = project.description;
    projectDM.endDate = project.endDate;
    projectDM.name = project.name;
    projectDM.startDate = project.startDate;
    projectDM.status = project.status;
    projectDM.userId = project.userId;
    projectDM.clientId = project.clientId;
    projectDM.vendorId = project.vendorId;
    projectDM.pmId = project.pmId;
    projectDM.file = project.file;
    projectDM.fileName = project.fileName;

    return projectDM;
  }

  Future<String> createProject(ProjectFirebase project) async {
    return await createData(
      CollectionType.projects.name,
      project.toFirestore(),
    );
  }

  Future<bool> updateProject(ProjectFirebase project) async {
    return await updateData(
      CollectionType.projects.name,
      project.id ?? "",
      project.toFirestore(),
    );
  }

  Future<bool> addProjectStaff(String projectId, String userId) async {
    return await updateData(
      CollectionType.projects.name,
      projectId,
      {
        "userId": FieldValue.arrayUnion([userId])
      },
    );
  }

  Future<bool> removeProjectStaff(String projectId, String userId) async {
    return await updateData(
      CollectionType.projects.name,
      projectId,
      {
        "userId": FieldValue.arrayRemove([userId])
      },
    );
  }

  Future<bool> updateProjectStatus(
    String id,
    String status, {
    File? file,
    Uint8List? fileWeb,
    String? currentUrl,
    String? fileName,
  }) async {
    if (status == ProjectStatusType.pendingClose.name) {
      String url = "";
      bool isDeleled = false;

      if (kIsWeb && (fileWeb?.isNotEmpty ?? false)) {
        String fileName = "project_bast_$id";

        if (currentUrl?.isNotEmpty ?? false) {
          isDeleled = await deleteFile("files/$fileName");
        }

        if (isDeleled || (currentUrl?.isEmpty ?? true)) {
          url = await uploadFile(
            "files/$fileName",
            fileWeb: fileWeb,
            contentType: "application/pdf",
          );
        } else {
          Helpers().showErrorSnackBar("Something went wrong");
          return false;
        }
      } else if (file?.path.isNotEmpty ?? false) {
        XFile fileToUpload = XFile(
          file?.path ?? "",
          name: "project_bast_$id",
        );

        String ref = await getRefFromUrl(currentUrl ?? "");
        if (currentUrl?.isNotEmpty ?? false) {
          isDeleled = await deleteFile("files/$ref");
        }

        if (isDeleled || (currentUrl?.isEmpty ?? true)) {
          url = await uploadFile(
            "files",
            file: fileToUpload,
            contentType: "application/pdf",
          );
        } else {
          Helpers().showErrorSnackBar("Something went wrong");
          return false;
        }
      } else {
        Helpers.writeLog("file is same");
        url = currentUrl ?? "";
      }

      if (url.isNotEmpty) {
        return await updateData(
          CollectionType.projects.name,
          id,
          {
            "status": status,
            "file": url,
            "fileName": fileName,
          },
        );
      } else {
        Helpers.writeLog("Error: url is empty");
        return false;
      }
    } else {
      return await updateData(
        CollectionType.projects.name,
        id,
        {"status": status},
      );
    }
  }

  Future<bool> deleteProject(String id) async {
    return await deleteData(CollectionType.projects.name, id);
  }
}
