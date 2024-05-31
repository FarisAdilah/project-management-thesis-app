import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/staffPage/component/staff_item_content.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffList/controller_staff_list.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class StaffList extends StatelessWidget {
  const StaffList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StaffListController());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText("Ini Halaman Untuk Data Staff"),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onPressed: () => controller.showCreateForm(context),
              text: "Add Staff",
              color: AssetColor.blueTertiaryAccent,
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => ListView.builder(
                itemCount: controller.users.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  UserDM user = controller.users[index];

                  return StaffItemContent(
                    user: user,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
