import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class StaffItemContent extends StatelessWidget {
  final UserDM user;
  final String imageUrl;
  const StaffItemContent({
    super.key,
    required this.user,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: AssetColor.bluePrimaryAccent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AssetColor.blueSecondaryAccent,
            foregroundImage: NetworkImage(imageUrl),
            // child: Image.network(
            //   imageUrl,
            //   fit: BoxFit.fill,
            // ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.name}",
                style: const TextStyle(
                  color: AssetColor.whitePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${user.role}",
                style: const TextStyle(
                  color: AssetColor.whitePrimary,
                ),
              ),
            ],
          ),
        ],
      ),
      // ListTile(
      //   title: Text("${user.name}"),
      //   subtitle: Text("Role: ${user.role}"),
      //   onTap: () {
      //     Helpers().showSuccessSnackBar("${user.id}");
      //   },
      // ),
    );
  }
}
