import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/vendorPage/component/vendor_detail.dart';
import 'package:project_management_thesis_app/pages/vendorPage/vendorForm/vendor_form.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class VendorListController extends GetxController with Storage {
  final _vendorRepository = VendorRepository.instance;

  RxList<VendorDM> vendors = <VendorDM>[].obs;

  RxBool isLoading = false.obs;
  RxInt selectedIndex = (-1).obs;

  UserDM? currentUser = UserDM();

  @override
  void onInit() async {
    super.onInit();
    currentUser = await getUserData();
    await _getVendorList();
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

  // setSelectedVendor(int index) {
  //   selectedIndex.value = index;
  //   Helpers.writeLog("selectedVendor: $selectedIndex");
  // }

  showCreateForm() {
    Get.to(() => const VendorForm())?.whenComplete(() => _getVendorList());
  }

  showEditForm(VendorDM vendor) {
    Get.to(
      () => VendorForm(
        vendor: vendor,
        isUpdate: true,
      ),
    )?.whenComplete(() {
      selectedIndex.value = -1;
      _getVendorList();
    });
  }

  onDeleteVendor(VendorDM vendor) {
    Get.dialog(
      AlertDialog(
        title: const CustomText(
          "Delete Vendor",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AssetColor.greyBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 16,
        ),
        content: CustomText(
          "Are you sure you want to delete ${vendor.name}?",
          fontSize: 18,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 16,
        ),
        actions: [
          TextButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AssetColor.orangeButton,
              ),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const CustomText(
              "Cancel",
              color: AssetColor.whiteBackground,
            ),
          ),
          TextButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AssetColor.redButton,
              ),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
              ),
            ),
            onPressed: () {
              Get.back();
              selectedIndex.value = -1;
              _deleteVendor(vendor);
            },
            child: const CustomText(
              "Delete",
              color: AssetColor.whiteBackground,
            ),
          ),
        ],
      ),
    );
  }

  _deleteVendor(VendorDM vendor) async {
    isLoading.value = true;
    bool isDeleted = await _vendorRepository.deleteVendor(
      vendor.id ?? "",
      vendor.image ?? "",
    );
    if (isDeleted) {
      Helpers().showSuccessSnackBar("Vendor has been deleted successfully");
      _getVendorList();
    } else {
      Helpers().showErrorSnackBar("Failed to delete vendor");
    }
  }

  showVendorDetail(VendorDM vendor) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AssetColor.greyBackground,
        contentPadding: const EdgeInsets.all(0),
        content: VendorDetail(
          vendor: vendor,
          onClose: () => Get.back(),
          onEditVendor: (vendor) {
            showEditForm(vendor);
          },
          onDeleteVendor: (vendor) {
            onDeleteVendor(vendor);
          },
        ),
      ),
    );
  }
}
