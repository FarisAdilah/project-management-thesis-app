import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/avatar/profile_picture.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffForm/staff_form.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class StaffItemContent extends StatelessWidget {
  final UserDM user;
  final UserDM currentUser;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final bool isHover;
  final Function(bool) onHover;
  final VoidCallback onTap;

  const StaffItemContent({
    super.key,
    required this.user,
    required this.onUpdate,
    required this.onDelete,
    required this.currentUser,
    this.isHover = false,
    required this.onHover,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) => onHover(value),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color:
              isHover ? AssetColor.greyBackground : AssetColor.whiteBackground,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AssetColor.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePicture(user: user),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "ID",
                    color: AssetColor.grey.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    "${user.id}",
                    color: AssetColor.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "Name",
                    color: AssetColor.grey.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    "${user.name}",
                    color: AssetColor.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "Email",
                    color: AssetColor.grey.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    "${user.email}",
                    color: AssetColor.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "Phone Number",
                    color: AssetColor.grey.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    "${user.phoneNumber}",
                    color: AssetColor.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "Role",
                    color: AssetColor.grey.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    Helpers().getUserRole(user.role ?? ""),
                    color: AssetColor.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            currentUser.role == UserType.supervisor.name
                ? Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "Action",
                          color: AssetColor.grey.withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: AssetColor.purple,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                constraints:
                                    BoxConstraints.tight(const Size(30, 30)),
                                padding: const EdgeInsets.all(0),
                                iconSize: 18,
                                icon: const Icon(
                                  FontAwesomeIcons.penToSquare,
                                  color: AssetColor.whiteBackground,
                                ),
                                onPressed: () {
                                  Get.to(
                                    () => StaffForm(
                                      userDM: user,
                                      isUpdate: true,
                                    ),
                                  )?.whenComplete(onUpdate);
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AssetColor.redButton,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                constraints:
                                    BoxConstraints.tight(const Size(30, 30)),
                                padding: const EdgeInsets.all(0),
                                iconSize: 18,
                                icon: const Icon(
                                  FontAwesomeIcons.trashCan,
                                  color: AssetColor.whiteBackground,
                                ),
                                onPressed: onDelete,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
