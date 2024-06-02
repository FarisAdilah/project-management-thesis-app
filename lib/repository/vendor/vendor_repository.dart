import 'package:project_management_thesis_app/repository/pic/dataModel/pic_dm.dart';
import 'package:project_management_thesis_app/repository/pic/pic_repository.dart';
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
      vendorDM.image = element.image;
      vendorDM.name = element.name;
      vendorDM.phoneNumber = element.phoneNumber;

      List<PicDM> pic = [];

      if (element.pic?.isNotEmpty ?? false) {
        for (var element in element.pic!) {
          PicDM picDM = await PicRepository().getPicById(element);
          pic.add(picDM);
        }
      }
      vendorDM.pic = pic;

      vendorDMList.add(vendorDM);
    }
    Helpers.writeLog("vendorDMList: ${vendorDMList.length}");

    return vendorDMList;
  }

  Future<List<VendorDM>> getMultipleVendor(List<String> ids) async {
    List<VendorDM> vendorDMList = [];

    for (var id in ids) {
      VendorDM vendorDM = await getVendorById(id);
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
    vendorDM.image = vendor.image;
    vendorDM.name = vendor.name;
    vendorDM.phoneNumber = vendor.phoneNumber;

    List<PicDM> pic = [];

    if (vendor.pic?.isNotEmpty ?? false) {
      for (var element in vendor.pic!) {
        PicDM picDM = await PicRepository().getPicById(element);

        pic.add(picDM);
      }
    }
    vendorDM.pic = pic;

    return vendorDM;
  }
}
