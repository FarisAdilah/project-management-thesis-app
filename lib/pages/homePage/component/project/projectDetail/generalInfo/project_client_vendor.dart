import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class ClientVendorProject extends StatelessWidget {
  const ClientVendorProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
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
          const CustomText(
            "Client & PIC",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AssetColor.greyBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              children: [
                CustomText("Client Name"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const CustomText(
            "Vendor & PIC List",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
