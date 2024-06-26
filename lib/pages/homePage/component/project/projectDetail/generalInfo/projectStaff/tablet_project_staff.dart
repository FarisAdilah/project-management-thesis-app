import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/avatar/profile_picture.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/project/projectDetail/generalInfo/projectStaff/controller_project_staff.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class TabletStaffProject extends StatelessWidget {
  final List<UserDM> staffList;
  final Function(UserDM) onStaffSelected;
  final Function(UserDM) onStaffRemoved;
  final String role;

  const TabletStaffProject({
    super.key,
    required this.staffList,
    required this.onStaffSelected,
    required this.onStaffRemoved,
    this.role = "staff",
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProjectStaffController(
      staffList: staffList,
      onStaffSelected: onStaffSelected,
    ));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AssetColor.whiteBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AssetColor.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomText(
                "Staff List",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(width: 20),
              role == UserType.projectManager.name
                  ? CustomButton(
                      text: "Add Staff",
                      borderRadius: 8,
                      color: AssetColor.greenButton,
                      textColor: AssetColor.whiteBackground,
                      onPressed: () {
                        controller.addNewStaff();
                      },
                    )
                  : const SizedBox(),
            ],
          ),
          staffList.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: CustomText(
                      "There's no Staff yet",
                      color: AssetColor.blackPrimary.withOpacity(0.5),
                      fontSize: 20,
                    ),
                  ),
                )
              : GridView.builder(
                  itemCount: staffList.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 7,
                  ),
                  itemBuilder: (context, index) {
                    final staff = staffList[index];

                    return Obx(
                      () => InkWell(
                        onTap: () {
                          controller.selectStaff(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AssetColor.whiteBackground,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AssetColor.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            border: Border.all(
                              color:
                                  controller.selectedStaffIndex.value == index
                                      ? AssetColor.blueSecondaryAccent
                                      : AssetColor.whiteBackground,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              ProfilePicture(
                                user: staff,
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    staff.name ?? "Staff Name",
                                    fontSize: 20,
                                  ),
                                  CustomText(
                                    staff.email ?? "Staff Email",
                                    fontSize: 18,
                                    color: AssetColor.grey,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: AssetColor.whiteBackground,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AssetColor.blueSecondaryAccent,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color:
                                          controller.selectedStaffIndex.value ==
                                                  index
                                              ? AssetColor.blueSecondaryAccent
                                              : AssetColor.whiteBackground,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          Obx(
            () => Visibility(
              visible: controller.selectedStaffIndex.value != -1,
              child: Center(
                child: CustomButton(
                  text: "Remove Staff",
                  borderRadius: 8,
                  color: AssetColor.redButton,
                  textColor: AssetColor.whiteBackground,
                  onPressed: () {
                    onStaffRemoved(
                        staffList[controller.selectedStaffIndex.value]);
                    controller.selectedStaffIndex.value = -1;
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
