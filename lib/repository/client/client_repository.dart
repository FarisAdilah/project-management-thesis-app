import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/pic/dataModel/pic_dm.dart';
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
      ClientFirebase client = ClientFirebase.fromFirestoreList(element);
      clientList.add(client);
    }
    Helpers.writeLog("clientList: ${clientList.length}");

    List<ClientDM> clientDMList = [];

    for (var element in clientList) {
      ClientDM clientDM = ClientDM();
      clientDM.id = element.id;
      clientDM.address = element.address;
      clientDM.description = element.description;
      clientDM.email = element.email;
      clientDM.image = element.image;
      clientDM.name = element.name;
      clientDM.phoneNumber = element.phoneNumber;

      PicDM picDM = PicDM();
      picDM.email = element.pic?.email;
      picDM.name = element.pic?.name;
      picDM.phoneNumber = element.pic?.phoneNumber;
      picDM.role = element.pic?.role;

      clientDM.pic = picDM;

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
    clientDM.email = client.email;
    clientDM.image = client.image;
    clientDM.name = client.name;
    clientDM.phoneNumber = client.phoneNumber;

    PicDM pic = PicDM();
    pic.email = client.pic?.email;
    pic.name = client.pic?.name;
    pic.phoneNumber = client.pic?.phoneNumber;
    pic.role = client.pic?.role;

    clientDM.pic = pic;

    return clientDM;
  }

  Future<bool> createClient(
    ClientFirebase client, {
    File? image,
    Uint8List? imageWeb,
  }) async {
    String url = "";

    // Upload image to Firebase Storage
    if (kIsWeb && imageWeb != null) {
      String imageName =
          client.name?.trim().toLowerCase().replaceAll(" ", "_") ?? "";
      url = await uploadImage(
        "images/$imageName",
        imageWeb: imageWeb,
      );
    } else if (image != null) {
      XFile imageToUpload = XFile(image.path);
      url = await uploadImage(
        "images",
        image: imageToUpload,
      );
    }

    // Set Image Url
    if (url.isNotEmpty) {
      client.image = url;
    } else {
      Helpers().showErrorSnackBar("Failed to upload image");
    }

    bool isSuccess =
        await createData(CollectionType.clients.name, client.toFirestore());

    return isSuccess;
  }
}
