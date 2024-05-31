import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class ClientItemContent extends StatelessWidget {
  final ClientDM? client;

  const ClientItemContent({
    super.key,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: AssetColor.blueTertiaryAccent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: AssetColor.blueSecondaryAccent,
            backgroundImage: null,
            child: CustomText(
              "A",
              color: AssetColor.whitePrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "${client?.name}",
                color: AssetColor.whitePrimary,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                "${client?.address}",
                color: AssetColor.whitePrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
