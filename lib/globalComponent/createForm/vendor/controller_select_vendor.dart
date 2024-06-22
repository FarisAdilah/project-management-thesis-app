import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/repository/vendor/vendor_repository.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class SelectVendorController extends GetxController {
  final _vendorRepo = VendorRepository.instance;

  RxBool isLoading = false.obs;

  RxList<VendorDM> vendors = <VendorDM>[].obs;

  Rx<VendorDM> selectedVendor = VendorDM().obs;

  VendorDM? initialVendor;
  final String projectId;
  final List<VendorDM>? initSelectedVendor;
  final List<VendorDM>? availableVendor;

  SelectVendorController({
    this.initialVendor,
    required this.projectId,
    this.initSelectedVendor,
    this.availableVendor,
  });

  @override
  void onInit() async {
    super.onInit();
    await getVendors();
  }

  getVendors() async {
    if (availableVendor != null && (availableVendor?.isNotEmpty ?? false)) {
      vendors.value = availableVendor ?? [];
      selectedVendor.value = initialVendor ?? VendorDM();
      return;
    }

    isLoading.value = true;
    vendors.value = await _vendorRepo.getAllVendor();
    isLoading.value = false;

    Helpers.writeLog("initvendor: ${initSelectedVendor?.length}");

    if (initSelectedVendor != null &&
        (initSelectedVendor?.isNotEmpty ?? false)) {
      vendors.value = vendors.where((element) {
        return initSelectedVendor!
            .where((element2) => element2.id == element.id)
            .isEmpty;
      }).toList();

      Helpers.writeLog("vendor: ${vendors.length}");
    } else {
      selectedVendor.value = initialVendor ?? VendorDM();
    }
  }

  setVendorSelected(VendorDM vendor) {
    selectedVendor.value = vendor;
  }
}
