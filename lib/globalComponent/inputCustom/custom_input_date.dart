import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class CustomInputDate extends StatelessWidget {
  final TextEditingController dateController;
  final VoidCallback onTap;

  const CustomInputDate({
    super.key,
    required this.dateController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          "Start Date",
          color: AssetColor.blackPrimary,
          fontSize: 16,
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AssetColor.grey,
                  width: 1,
                ),
              ),
            ),
            child: TextField(
              controller: dateController,
              decoration: InputDecoration(
                hintText: "input Start Date",
                hintStyle: TextStyle(
                  color: AssetColor.grey.withOpacity(0.5),
                  fontFamily: "Jost",
                  fontWeight: FontWeight.normal,
                ),
                suffixIcon: const Icon(FontAwesomeIcons.calendar),
              ),
              keyboardType: TextInputType.datetime,
            ),
          ),
        ),
      ],
    );
  }
}
