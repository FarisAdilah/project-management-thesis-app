import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class ClientItemContent extends StatelessWidget {
  final ClientDM client;
  final VoidCallback onPressed;

  const ClientItemContent({
    super.key,
    required this.client,
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
                color: client.image?.isNotEmpty ?? false
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
                child: client.image?.isNotEmpty ?? false
                    ? Image.network(
                        client.image ?? "",
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: CustomText(
                          "${client.name?.toUpperCase()}",
                          fontSize: 30,
                          color: AssetColor.blackPrimary,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    "${client.name}",
                    fontSize: 20,
                    color: AssetColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                    "Email",
                    color: AssetColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    "${client.email}",
                    color: AssetColor.black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomText(
                    "Phone Number",
                    color: AssetColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    "${client.phoneNumber}",
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
