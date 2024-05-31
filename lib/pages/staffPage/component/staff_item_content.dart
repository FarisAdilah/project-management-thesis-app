import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/avatar/profile_picture.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class StaffItemContent extends StatelessWidget {
  final UserDM user;

  const StaffItemContent({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: AssetColor.blueTertiaryAccent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          ProfilePicture(user: user),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "${user.name}",
                color: AssetColor.whitePrimary,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                "${user.role}",
                color: AssetColor.whitePrimary,
              ),
            ],
          ),
        ],
      ),
      // ListTile(
      //   title: CustomText("${user.name}"),
      //   subtitle: CustomText("Role: ${user.role}"),
      //   onTap: () {
      //     Helpers().showSuccessSnackBar("${user.id}");
      //   },
      // ),
    );
  }
}
