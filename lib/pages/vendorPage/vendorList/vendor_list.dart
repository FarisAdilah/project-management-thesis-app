import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/vendorPage/component/vendor_item_content.dart';
import 'package:project_management_thesis_app/pages/vendorPage/vendorList/controller_vendor_list.dart';

class VendorList extends StatelessWidget {
  const VendorList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorListController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 10,
          ),
          child: Column(
            children: [
              const CustomText("Ini Halaman Untuk Data Vendor"),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => ListView.builder(
                  itemCount: controller.vendors.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var vendor = controller.vendors[index];

                    return VendorItemContent(vendor: vendor);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
