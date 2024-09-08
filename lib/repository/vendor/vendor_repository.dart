import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_management_thesis_app/repository/pic/dataModel/pic_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/firebaseModel/vendor_firebase.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class VendorRepository with RepoBase {
  static VendorRepository get instance => VendorRepository();

  Future<List<VendorDM>> getAllVendor() async {
    List collection = await getDataCollection(CollectionType.vendors.name);

    List<VendorFirebase> vendorList = [];

    for (var element in collection) {
      VendorFirebase vendor = VendorFirebase.fromFirestoreList(element);
      vendorList.add(vendor);
    }
    Helpers.writeLog("vendorList: ${vendorList.length}");

    List<VendorDM> vendorDMList = [];

    for (var element in vendorList) {
      VendorDM vendorDM = VendorDM();
      vendorDM.id = element.id;
      vendorDM.address = element.address;
      vendorDM.description = element.description;
      vendorDM.email = element.email;
      vendorDM.image = element.image;
      vendorDM.name = element.name;
      vendorDM.phoneNumber = element.phoneNumber;
      vendorDM.projectId = element.projectId;

      PicDM pic = PicDM();
      pic.email = element.pic?.email;
      pic.name = element.pic?.name;
      pic.phoneNumber = element.pic?.phoneNumber;
      pic.role = element.pic?.role;

      vendorDM.pic = pic;

      vendorDMList.add(vendorDM);
    }
    Helpers.writeLog("vendorDMList: ${vendorDMList.length}");

    return vendorDMList;
  }

  Future<List<VendorDM>> getMultipleVendor(String projectId) async {
    List collection = await getMultipleDocument(
      CollectionType.vendors.name,
      "projectId",
      projectId,
      isArray: true,
    );

    List<VendorFirebase> vendorList = [];
    for (var element in collection) {
      VendorFirebase vendor = VendorFirebase.fromFirestoreList(element);
      vendorList.add(vendor);
    }

    List<VendorDM> vendorDMList = [];
    for (var vendor in vendorList) {
      VendorDM vendorDM = VendorDM();
      vendorDM.id = vendor.id;
      vendorDM.address = vendor.address;
      vendorDM.description = vendor.description;
      vendorDM.email = vendor.email;
      vendorDM.image = vendor.image;
      vendorDM.name = vendor.name;
      vendorDM.phoneNumber = vendor.phoneNumber;
      vendorDM.projectId = vendor.projectId;

      PicDM pic = PicDM();
      pic.email = vendor.pic?.email;
      pic.name = vendor.pic?.name;
      pic.phoneNumber = vendor.pic?.phoneNumber;
      pic.role = vendor.pic?.role;

      vendorDM.pic = pic;

      vendorDMList.add(vendorDM);
    }

    return vendorDMList;
  }

  Future<VendorDM> getVendorById(String id) async {
    var data = await getDataDocument(CollectionType.vendors.name, id);
    VendorFirebase vendor = VendorFirebase.fromFirestoreDoc(data);

    VendorDM vendorDM = VendorDM();
    vendorDM.id = vendor.id;
    vendorDM.address = vendor.address;
    vendorDM.description = vendor.description;
    vendorDM.email = vendor.email;
    vendorDM.image = vendor.image;
    vendorDM.name = vendor.name;
    vendorDM.phoneNumber = vendor.phoneNumber;
    vendorDM.projectId = vendor.projectId;

    PicDM pic = PicDM();
    pic.email = vendor.pic?.email;
    pic.name = vendor.pic?.name;
    pic.phoneNumber = vendor.pic?.phoneNumber;
    pic.role = vendor.pic?.role;

    vendorDM.pic = pic;

    return vendorDM;
  }

  Future<bool> createVendor(
    VendorFirebase vendor, {
    File? image,
    Uint8List? imageWeb,
  }) async {
    String url = "";

    // Upload image to Firebase Storage
    if (kIsWeb && imageWeb != null) {
      String imageName =
          vendor.name?.trim().toLowerCase().replaceAll(" ", "_") ?? "";
      url = await uploadFile(
        "images/$imageName",
        fileWeb: imageWeb,
      );
    } else if (image != null) {
      XFile imageToUpload = XFile(image.path);
      url = await uploadFile(
        "images",
        file: imageToUpload,
      );
    }

    // Set Image Url
    if (url.isNotEmpty) {
      vendor.image = url;
    } else {
      Helpers().showErrorSnackBar("Failed to upload image");
    }

    String vendorId =
        await createData(CollectionType.vendors.name, vendor.toFirestore());

    if (vendorId.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateVendor(
    VendorFirebase vendor, {
    File? image,
    Uint8List? imageWeb,
  }) async {
    String url = "";
    bool isDeleted = false;

    // Upload image to Firebase Storage
    if (kIsWeb && (imageWeb?.isNotEmpty ?? false)) {
      String imageName =
          vendor.name?.trim().toLowerCase().replaceAll(" ", "_") ?? "";

      isDeleted = await deleteFile("images/$imageName");

      if (isDeleted) {
        url = await uploadFile(
          "images/$imageName",
          fileWeb: imageWeb,
        );
      } else {
        Helpers().showErrorSnackBar("Something went wrong");
        return false;
      }
    } else if (image?.path.isNotEmpty ?? false) {
      XFile imageToUpload = XFile(image?.path ?? "");

      String ref = await getRefFromUrl(vendor.image ?? "");
      isDeleted = await deleteFile("images/$ref");

      if (isDeleted) {
        url = await uploadFile(
          "images",
          file: imageToUpload,
        );
      } else {
        Helpers().showErrorSnackBar("Something went wrong");
        return false;
      }
    } else {
      url = vendor.image ?? "";
    }

    // Set Image Url
    if (url.isNotEmpty) {
      vendor.image = url;
    } else {
      Helpers().showErrorSnackBar("Failed to upload image");
    }

    bool isSuccess = await updateData(
      CollectionType.vendors.name,
      vendor.id ?? "",
      vendor.toFirestore(),
    );

    if (isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteVendor(String id, String imageUrl) async {
    String url = await getRefFromUrl(imageUrl);

    bool isDeleteImage;
    if (url.isNotEmpty) {
      isDeleteImage = await deleteFile("images/$url");
    } else {
      Helpers().showErrorSnackBar("Something went wrong");
      return false;
    }

    bool isDeleted = false;
    if (isDeleteImage) {
      isDeleted = await deleteData(CollectionType.vendors.name, id);
    }

    if (isDeleted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addVendorProjectId(String id, String projectId) {
    return updateData(
      CollectionType.vendors.name,
      id,
      {
        "projectId": FieldValue.arrayUnion([projectId])
      },
    );
  }
}
