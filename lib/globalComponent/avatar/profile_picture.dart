import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ProfilePicture extends StatelessWidget {
  final UserDM user;
  final Color? backgroundColor;
  final double? initialNameSize;

  const ProfilePicture({
    super.key,
    required this.user,
    this.backgroundColor,
    this.initialNameSize,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: backgroundColor ?? AssetColor.whitePrimary,
      backgroundImage: user.image?.isNotEmpty ?? false
          ? NetworkImage(
              user.image!,
            )
          : null,
      child: user.image?.isEmpty ?? true
          ? CustomText(
              Helpers().getInitialName(user.name ?? "user name"),
              color: AssetColor.blueTertiaryAccent,
              fontWeight: FontWeight.bold,
              fontSize: initialNameSize ?? 20,
            )
          : null,
    );
  }
}
