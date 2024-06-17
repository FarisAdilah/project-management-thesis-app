import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/vendorPage/component/vendor_detail.dart';
import 'package:project_management_thesis_app/pages/vendorPage/component/vendor_item_content.dart';
import 'package:project_management_thesis_app/pages/vendorPage/vendorList/controller_vendor_list.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

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
                  controller.currentUser?.role == UserType.admin.name
                      ? Column(
                          children: [
                            CustomButton(
                              onPressed: () => controller.showCreateForm(),
                              text: "Add New Vendor",
                              color: AssetColor.greenButton,
                              borderRadius: 8,
                              boxShadow: [
                                BoxShadow(
                                  color: AssetColor.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.85,
                      ),
                      shrinkWrap: true,
                      itemCount: controller.vendors.length,
                      itemBuilder: (context, index) {
                        var vendor = controller.vendors[index];

                        return VendorItemContent(
                          vendor: vendor,
                          onPressed: () => controller.showVendorDetail(vendor),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Obx(
            //   () => Visibility(
            //     visible: controller.selectedIndex.value != -1,
            //     child:
            //   ),
            // ),
            controller.isLoading.value ? const Loading() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
