import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';

class SelectVendorController extends GetxController {
  final _vendorRepo = VendorRepository.instance;

  RxBool isLoading = false.obs;

  RxList<VendorDM> vendors = <VendorDM>[].obs;

  Rx<VendorDM> selectedVendor = VendorDM().obs;

  VendorDM? initialVendor;
  final String projectId;

  SelectVendorController({
    this.initialVendor,
    required this.projectId,
  });

  @override
  void onInit() async {
    super.onInit();
    await getVendors();
  }

  getVendors() async {
    isLoading.value = true;
    vendors.value = await _vendorRepo.getAllVendor();
    isLoading.value = false;

    selectedVendor.value =
        vendors.firstWhere((element) => element.id == selectedVendor.value.id);
  }

  setVendorSelected(VendorDM vendor) {
    selectedVendor.value = vendor;
  }
}
