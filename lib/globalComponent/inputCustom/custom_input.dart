import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class CustomInput extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? hintText;

  const CustomInput({
    super.key,
    required this.title,
    required this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          color: AssetColor.blackPrimary,
          fontSize: 16,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText ?? "input $title",
            hintStyle: TextStyle(
              color: AssetColor.grey.withOpacity(0.5),
              fontFamily: "Jost",
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
