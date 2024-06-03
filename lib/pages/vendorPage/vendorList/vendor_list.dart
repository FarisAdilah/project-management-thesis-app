import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/vendorPage/component/vendor_detail.dart';
import 'package:project_management_thesis_app/pages/vendorPage/component/vendor_item_content.dart';
import 'package:project_management_thesis_app/pages/vendorPage/vendorList/controller_vendor_list.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class VendorList extends StatelessWidget {
  const VendorList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorListController());

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              color: AssetColor.greyBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Vendor List",
                    fontSize: 36,
                    color: AssetColor.blackPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: AssetColor.grey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      shrinkWrap: true,
                      itemCount: controller.vendors.length,
                      itemBuilder: (context, index) {
                        var vendor = controller.vendors[index];

                        return VendorItemContent(
                          vendor: vendor,
                          onPressed: () => controller.setSelectedVendor(index),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.selectedIndex.value != -1,
                child: VendorDetail(
                  vendor: controller.selectedIndex.value != -1
                      ? controller.vendors[controller.selectedIndex.value]
                      : VendorDM(),
                  onPressed: () => controller.setSelectedVendor(-1),
                ),
              ),
            ),
            controller.isLoading.value ? const Loading() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
