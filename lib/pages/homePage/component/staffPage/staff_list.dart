import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/staffContent/staff_item_content.dart';
import 'package:project_management_thesis_app/pages/homePage/component/staffPage/controller_staff_list.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';

class StaffList extends StatelessWidget {
  const StaffList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StaffListController());

    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("Ini Halaman Untuk Data Staff"),
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
                  imageUrl: controller.imageUrl.value,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
