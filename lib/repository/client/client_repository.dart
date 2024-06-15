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
      clientDM.projectId = element.projectId;

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

  Future<List<ClientDM>> getMultipleClientByProject(String projectId) async {
    List collection = await getMultipleDocument(
      CollectionType.clients.name,
      "projectId",
      projectId,
      isArray: true,
    );

    Helpers.writeLog("collection: ${collection.length}");

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
      clientDM.projectId = element.projectId;

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
    clientDM.projectId = client.projectId;

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

  Future<bool> updateClient(
    ClientFirebase client, {
    File? image,
    Uint8List? imageWeb,
  }) async {
    String url = "";
    bool isDeleted = false;

    // Upload image to Firebase Storage
    if (kIsWeb && (imageWeb?.isNotEmpty ?? false)) {
      String imageName =
          client.name?.trim().toLowerCase().replaceAll(" ", "_") ?? "";

      isDeleted = await deleteImage("images/$imageName");

      if (isDeleted) {
        url = await uploadImage(
          "images/$imageName",
          imageWeb: imageWeb,
        );
      } else {
        Helpers().showErrorSnackBar("Something went wrong");
        return false;
      }
    } else if (image?.path.isNotEmpty ?? false) {
      XFile imageToUpload = XFile(image?.path ?? "");

      String ref = await getImageRefFromUrl(client.image ?? "");
      isDeleted = await deleteImage("images/$ref");

      if (isDeleted) {
        url = await uploadImage(
          "images",
          image: imageToUpload,
        );
      } else {
        Helpers().showErrorSnackBar("Something went wrong");
        return false;
      }
    } else {
      url = client.image ?? "";
    }

    // Set Image Url
    if (url.isNotEmpty) {
      client.image = url;
    } else {
      Helpers().showErrorSnackBar("Failed to upload image");
    }

    bool isSuccess = await updateData(
      CollectionType.clients.name,
      client.id ?? "",
      client.toFirestore(),
    );

    if (isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteClient(String id, String imageUrl) async {
    String url = await getImageRefFromUrl(imageUrl);

    bool isDeleteImage;
    if (url.isNotEmpty) {
      isDeleteImage = await deleteImage("images/$url");
    } else {
      Helpers().showErrorSnackBar("Something went wrong");
      return false;
    }

    bool isDeleted = false;
    if (isDeleteImage) {
      isDeleted = await deleteData(CollectionType.clients.name, id);
    }

    if (isDeleted) {
      return true;
    } else {
      return false;
    }
  }
}
