import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/payment/dataModel/payment_dm.dart';
import 'package:project_management_thesis_app/repository/payment/payment_repository.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/repository/project/firebaseModel/project_firebase.dart';
import 'package:project_management_thesis_app/repository/timeline/dataModel/timeline_dm.dart';
import 'package:project_management_thesis_app/repository/timeline/timeline_repository.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ProjectRepository with RepoBase {
  static ProjectRepository get instance => ProjectRepository();

  Future<List<ProjectDM>> getAllProjects() async {
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
      projectDM.description = element.description;
      projectDM.endDate = element.endDate;
      projectDM.name = element.name;
      projectDM.startDate = element.startDate;
      projectDM.status = element.status;

      // Get Client
      if (element.client != null) {
        ClientDM? clientDM = await _getProjectClient(element.client!);
        if (clientDM == null) {
          return [];
        }
        projectDM.client = clientDM;
      }

      // Get Vendor
      if (element.vendor != null) {
        projectDM.vendor = await _getProjectVendors(element.vendor!);
      }

      // Get Timeline
      if (element.timeline != null) {
        projectDM.timeline = await _getProjectTimelines(element.timeline!);
      }

      // Get Payment
      if (element.payment != null) {
        projectDM.payment = await _getProjectPayments(element.payment!);
      }

      projectDMList.add(projectDM);
    }
    Helpers.writeLog("projectDMList: ${projectDMList.length}");

    return projectDMList;
  }

  Future<ProjectDM?> getProjectById(String id) async {
    var data = await getDataDocument(CollectionType.projects.name, id);
    ProjectFirebase project = ProjectFirebase.fromFirestore(data);

    ProjectDM projectDM = ProjectDM();
    projectDM.id = project.id;
    projectDM.description = project.description;
    projectDM.endDate = project.endDate;
    projectDM.name = project.name;
    projectDM.startDate = project.startDate;
    projectDM.status = project.status;

    // Get Client
    if (project.client != null) {
      ClientDM? clientDM = await _getProjectClient(project.client!);
      if (clientDM != null) {
        projectDM.client = clientDM;
      } else {
        return null;
      }
    }

    // Get Vendor
    projectDM.vendor = await _getProjectVendors(project.vendor!);

    // Get Timeline
    projectDM.timeline = await _getProjectTimelines(project.timeline!);

    // Get Payment
    projectDM.payment = await _getProjectPayments(project.payment!);

    return projectDM;
  }

  Future<ClientDM?> _getProjectClient(String id) async {
    ClientDM clientDM = ClientDM();
    if (id.isNotEmpty) {
      clientDM = await ClientRepository().getClientById(id);
    } else {
      return null;
    }
    return clientDM;
  }

  Future<List<VendorDM>?> _getProjectVendors(List<String> ids) async {
    List<VendorDM> vendorListDM = [];
    if (ids.isNotEmpty) {
      List<VendorDM> data = await VendorRepository().getMultipleVendor(ids);
      vendorListDM = data;
    }
    return vendorListDM;
  }

  Future<List<TimelineDM>?> _getProjectTimelines(List<String> ids) async {
    List<TimelineDM> timelineListDM = [];
    if (ids.isNotEmpty) {
      List<TimelineDM> data =
          await TimelineRepository().getMultipleTimeline(ids);
      timelineListDM = data;
    }
    return timelineListDM;
  }

  Future<List<PaymentDM>?> _getProjectPayments(List<String> ids) async {
    List<PaymentDM> paymentListDM = [];
    if (ids.isNotEmpty) {
      List<PaymentDM> data = await PaymentRepository().getMultiplePayment(ids);
      paymentListDM = data;
    }
    return paymentListDM;
  }
}
