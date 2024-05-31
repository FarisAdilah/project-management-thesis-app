import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class VendorItemContent extends StatelessWidget {
  final VendorDM? vendor;

  const VendorItemContent({
    super.key,
    required this.vendor,
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
            backgroundColor: Colors.blueAccent,
            backgroundImage: null,
            child: CustomText(
              "A",
              color: AssetColor.whitePrimary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "${vendor?.name}",
                color: AssetColor.whitePrimary,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                "${vendor?.address}",
                color: AssetColor.whitePrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
