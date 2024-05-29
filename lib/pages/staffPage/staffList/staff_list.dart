import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/staffPage/component/staff_item_content.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffList/controller_staff_list.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';

class StaffList extends StatelessWidget {
  final List<UserDM> users;

  const StaffList({
    super.key,
    required this.users,
  });

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
              itemCount: users.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                UserDM user = users[index];

                return Obx(
                  () => StaffItemContent(
                    user: user,
                    imageUrl: controller.imageUrl.value,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
