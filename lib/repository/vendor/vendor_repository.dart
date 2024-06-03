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
    vendorDM.email = vendor.email;
    vendorDM.image = vendor.image;
    vendorDM.name = vendor.name;
    vendorDM.phoneNumber = vendor.phoneNumber;

    PicDM pic = PicDM();
    pic.email = vendor.pic?.email;
    pic.name = vendor.pic?.name;
    pic.phoneNumber = vendor.pic?.phoneNumber;
    pic.role = vendor.pic?.role;

    vendorDM.pic = pic;

    return vendorDM;
  }
}
