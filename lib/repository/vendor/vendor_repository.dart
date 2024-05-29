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
      VendorFirebase vendor = VendorFirebase.fromFirestore(element);
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

      List<String> pic = [];

      if (element.pic != null && pic.isNotEmpty) {
        for (var element in element.pic!) {
          pic.add(element);
        }
      }

      vendorDM.pic = pic;
      vendorDMList.add(vendorDM);
    }
    Helpers.writeLog("vendorDMList: ${vendorDMList.length}");

    return vendorDMList;
  }
}
