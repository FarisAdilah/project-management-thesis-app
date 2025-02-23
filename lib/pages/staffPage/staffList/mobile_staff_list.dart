import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/staffPage/component/mobile_staff_item_content.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffList/controller_staff_list.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class MobileStaffList extends StatelessWidget {
  const MobileStaffList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StaffListController());

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                color: AssetColor.greyBackground,
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "User List",
                      color: AssetColor.blackPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () {
                        int supervisor = controller.totalSupervisor.value;
                        int admin = controller.totalAdmin.value;
                        int projectManager =
                            controller.totalProjectManager.value;
                        int staff = controller.totalStaff.value;
                        return Column(
                          children: [
                            Row(
                              children: [
                                _buildTag(supervisor, "Supervisor"),
                                const SizedBox(width: 10),
                                _buildTag(admin, "Admin"),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _buildTag(projectManager, "Project Manager"),
                                const SizedBox(width: 10),
                                _buildTag(staff, "Staff"),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      color: AssetColor.grey,
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.currentUser?.role == UserType.supervisor.name
                        ? Column(
                            children: [
                              CustomButton(
                                onPressed: () =>
                                    controller.showCreateForm(context),
                                text: "Add New User",
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
                                height: 20,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    Obx(
                      () => ListView.builder(
                        itemCount: controller.users.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          UserDM user = controller.users[index];

                          return MobileStaffItemContent(
                            user: user,
                            currentUser: controller.currentUser ?? UserDM(),
                            onUpdate: () => controller.onUpdateUser(),
                            onDelete: () => controller.onDeleteUser(user),
                            onTap: () => controller.showUserDetail(user),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            controller.isLoading.value ? const Loading() : const SizedBox()
          ],
        ),
      ),
    );
  }
}

Widget _buildTag(int count, String title) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    decoration: BoxDecoration(
        color: AssetColor.whiteBackground,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AssetColor.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          count.toString(),
          color: AssetColor.greenButton,
          fontSize: 16,
        ),
        const SizedBox(width: 8),
        CustomText(
          title,
          color: AssetColor.blackPrimary,
          fontSize: 16,
        ),
      ],
    ),
  );
}
