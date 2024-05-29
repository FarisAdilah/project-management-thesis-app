import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/client/firebaseModel/client_firebase.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ClientRepository with RepoBase {
  static ClientRepository get instance => ClientRepository();

  Future<List<ClientDM>> getAllClient() async {
    List collection = await getDataCollection(CollectionType.clients.name);

    List<ClientFirebase> clientList = [];

    for (var element in collection) {
      ClientFirebase client = ClientFirebase.fromFirestore(element);
      clientList.add(client);
    }
    Helpers.writeLog("clientList: ${clientList.length}");

    List<ClientDM> clientDMList = [];

    for (var element in clientList) {
      ClientDM clientDM = ClientDM();
      clientDM.id = element.id;
      clientDM.address = element.address;
      clientDM.description = element.description;
      clientDM.image = element.image;
      clientDM.name = element.name;
      clientDM.phoneNumber = element.phoneNumber;

      List<String> pic = [];

      if (element.pic != null && pic.isNotEmpty) {
        for (var element in element.pic!) {
          pic.add(element);
        }
      }

      clientDM.pic = pic;
      clientDMList.add(clientDM);
    }
    Helpers.writeLog("clientDMList: ${clientDMList.length}");

    return clientDMList;
  }
}
