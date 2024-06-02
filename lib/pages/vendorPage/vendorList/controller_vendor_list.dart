import 'dart:convert';

import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class VendorListController extends GetxController {
  final _vendorRepository = VendorRepository.instance;

  RxList<VendorDM> vendors = <VendorDM>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getVendorList();
  }

  _getVendorList() async {
    isLoading.value = true;
    var response = await _vendorRepository.getAllVendor();

    if (response.isNotEmpty) {
      vendors.value = response;
      Helpers.writeLog("response: ${jsonEncode(vendors)}");
    } else {
      Helpers().showErrorSnackBar("Failed to get vendor data");
    }
    isLoading.value = false;
  }
}
