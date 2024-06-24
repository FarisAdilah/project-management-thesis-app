import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/vendorPage/component/mobile_vendor_item_content.dart';
import 'package:project_management_thesis_app/pages/vendorPage/vendorList/controller_vendor_list.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class MobileVendorList extends StatelessWidget {
  const MobileVendorList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorListController());

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                // height: MediaQuery.sizeOf(context).height,
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
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.vendors.length,
                        itemBuilder: (context, index) {
                          var vendor = controller.vendors[index];

                          return MobileVendorItemContent(
                            vendor: vendor,
                            onPressed: () =>
                                controller.showVendorDetail(vendor),
                          );
                        },
                      ),
                    ),
                  ],
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
