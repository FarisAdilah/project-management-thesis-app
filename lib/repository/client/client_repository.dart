import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/pic/dataModel/pic_dm.dart';
import 'package:project_management_thesis_app/repository/client/firebaseModel/client_firebase.dart';
import 'package:project_management_thesis_app/repository/pic/firebaseModel/pic_firebase.dart';
import 'package:project_management_thesis_app/repository/pic/pic_repository.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ClientRepository with RepoBase {
  static ClientRepository get instance => ClientRepository();

  Future<List<ClientDM>> getAllClient() async {
    List collection = await getDataCollection(CollectionType.clients.name);

    List<ClientFirebase> clientList = [];

    for (var element in collection) {
      ClientFirebase client = ClientFirebase.fromFirestoreDoc(element);
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

      List<PicDM> picDMList = [];
      if (element.pic?.isNotEmpty ?? false) {
        for (var element in element.pic!) {
          var pic = await getDataDocument(CollectionType.pics.name, element);

          PicFirebase picFirebase = PicFirebase.fromFirestoreDoc(pic);

          PicDM picDM = PicDM();
          picDM.id = picFirebase.id;
          picDM.email = picFirebase.email;
          picDM.name = picFirebase.name;
          picDM.phoneNumber = picFirebase.phoneNumber;
          picDM.role = picFirebase.role;

          picDMList.add(picDM);
        }
      }

      clientDM.pic = picDMList;
      clientDMList.add(clientDM);
    }
    Helpers.writeLog("clientDMList: ${clientDMList.length}");

    return clientDMList;
  }

  Future<ClientDM> getClientById(String id) async {
    var data = await getDataDocument(CollectionType.clients.name, id);
    ClientFirebase client = ClientFirebase.fromFirestoreDoc(data);

    ClientDM clientDM = ClientDM();
    clientDM.id = client.id;
    clientDM.address = client.address;
    clientDM.description = client.description;
    clientDM.image = client.image;
    clientDM.name = client.name;
    clientDM.phoneNumber = client.phoneNumber;

    List<PicDM> pic = [];
    if (client.pic?.isNotEmpty ?? false) {
      for (var element in client.pic!) {
        PicDM picDM = await PicRepository().getPicById(element);

        pic.add(picDM);
      }
    }
    clientDM.pic = pic;

    return clientDM;
  }
}
