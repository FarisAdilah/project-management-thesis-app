import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/avatar/profile_picture.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/staffPage/staffForm/mobile_staff_form.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class MobileStaffItemContent extends StatelessWidget {
  final UserDM user;
  final UserDM currentUser;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const MobileStaffItemContent({
    super.key,
    required this.user,
    required this.onUpdate,
    required this.onDelete,
    required this.currentUser,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AssetColor.whiteBackground,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AssetColor.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: ProfilePicture(user: user),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "${user.name}",
                      color: AssetColor.black,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      "${user.id}",
                      color: AssetColor.grey,
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              color: AssetColor.grey,
              thickness: 1,
            ),
            const SizedBox(
              width: 15,
            ),
            const SizedBox(
              width: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "Email",
                        color: AssetColor.grey.withOpacity(0.5),
                      ),
                      CustomText(
                        "${user.email}",
                        color: AssetColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "Phone Number",
                        color: AssetColor.grey.withOpacity(0.5),
                      ),
                      CustomText(
                        "${user.phoneNumber}",
                        color: AssetColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              "Role",
              color: AssetColor.grey.withOpacity(0.5),
            ),
            CustomText(
              Helpers().getUserRole(user.role ?? ""),
              color: AssetColor.black,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 15,
            ),
            currentUser.role == UserType.supervisor.name
                ? Column(
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
                                  () => MobileStaffForm(
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
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
