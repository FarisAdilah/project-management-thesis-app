import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/staff/controller_select_staff.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class TabletSelectStaff extends StatelessWidget {
  final UserDM? initialStaff;
  final List<UserDM> selectedStaffList;
  final Function(UserDM) onStaffSelected;
  final String? userRole;
  final String? title;
  final String? searchHint;
  final String? textButton;
  final bool isAlreadyExist;

  const TabletSelectStaff({
    super.key,
    this.initialStaff,
    required this.selectedStaffList,
    required this.onStaffSelected,
    this.userRole,
    this.title,
    this.searchHint,
    this.textButton,
    this.isAlreadyExist = true,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectStaffController(
      staffList: selectedStaffList,
      selectedStaff: initialStaff,
      userRole: userRole ?? "staff",
      isAlreadyExist: isAlreadyExist,
    ));

    return Obx(
      () => Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.75,
            width: MediaQuery.sizeOf(context).width * 0.5,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AssetColor.whiteBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      title ?? "Select Staff",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.xmark),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AssetColor.greyBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(FontAwesomeIcons.magnifyingGlass),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: searchHint ?? "Search staff",
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            controller.searchStaff(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                      itemCount: controller.staffsToShow.length,
                      itemBuilder: (context, index) {
                        final staff = controller.staffsToShow[index];

                        return InkWell(
                          onTap: () => controller.setStaffSelected(staff),
                          child: Obx(
                            () => Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AssetColor.whiteBackground,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: controller.currentSelection.value.id ==
                                          staff.id
                                      ? AssetColor.orangeButton
                                      : AssetColor.greyBackground,
                                ),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: staff.image != null
                                      ? NetworkImage(staff.image!)
                                      : null,
                                  child: staff.image == null
                                      ? CustomText(
                                          staff.name![0].toUpperCase(),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )
                                      : null,
                                ),
                                title: CustomText(
                                  staff.name ?? "Staff Name",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                subtitle: CustomText(
                                  staff.email ?? "Staff Email",
                                  fontSize: 16,
                                ),
                                trailing: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: AssetColor.whiteBackground,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: controller
                                                  .currentSelection.value.id ==
                                              staff.id
                                          ? AssetColor.orangeButton
                                          : AssetColor.greyBackground,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        color: controller.currentSelection.value
                                                    .id ==
                                                staff.id
                                            ? AssetColor.orangeButton
                                            : AssetColor.whiteBackground,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Obx(
                  () => Center(
                    child: CustomButton(
                      text: textButton ?? "Select Staff",
                      isEnabled:
                          controller.currentSelection.value.id?.isNotEmpty,
                      color: AssetColor.orangeButton,
                      disableColor: AssetColor.orangeButton.withOpacity(0.5),
                      textColor: AssetColor.whiteBackground,
                      onPressed: () {
                        onStaffSelected(
                          controller.currentSelection.value,
                        );
                        Get.back();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          controller.isLoading.value
              ? Loading(
                  height: MediaQuery.sizeOf(context).height * 0.75,
                  width: MediaQuery.sizeOf(context).width * 0.5,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
