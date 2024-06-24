import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/vendor/dataModel/vendor_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class WebVendorItemContent extends StatelessWidget {
  final VendorDM vendor;
  final VoidCallback onPressed;

  const WebVendorItemContent({
    super.key,
    required this.vendor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 25,
        bottom: 25,
      ),
      decoration: BoxDecoration(
        color: AssetColor.whiteBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AssetColor.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: vendor.image?.isNotEmpty ?? false
                    ? AssetColor.whiteBackground
                    : AssetColor.greyBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: vendor.image?.isNotEmpty ?? false
                    ? Image.network(
                        vendor.image ?? "",
                        fit: BoxFit.fitWidth,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8),
                        child: CustomText(
                          "${vendor.name?.toUpperCase()}",
                          color: AssetColor.blueTertiaryAccent,
                          fontSize: 30,
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "${vendor.name}",
                    color: AssetColor.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    "${vendor.address}",
                    color: AssetColor.black,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      borderRadius: 5,
                      text: "Detail Page",
                      textColor: AssetColor.whiteBackground,
                      color: AssetColor.blueDark,
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
