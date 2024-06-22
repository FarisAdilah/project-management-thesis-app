import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class CustomInput extends StatelessWidget {
  final String? title;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? inputType;
  final IconData? suffixIcon;
  final bool isPopupInput;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enabled;
  final Function(String)? onTyping;

  const CustomInput({
    super.key,
    this.title,
    required this.controller,
    this.hintText,
    this.inputType,
    this.suffixIcon,
    this.isPopupInput = false,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.onTyping,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? CustomText(
                title ?? "Input",
                color: AssetColor.blackPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
            : Container(),
        isPopupInput
            ? TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText ?? "input $title",
                  hintStyle: TextStyle(
                    color: AssetColor.grey.withOpacity(0.5),
                    fontFamily: "Jost",
                    fontWeight: FontWeight.normal,
                  ),
                  suffixIcon: suffixIcon != null
                      ? InkWell(
                          onTap: onTap,
                          child: Icon(suffixIcon),
                        )
                      : null,
                  border: const UnderlineInputBorder(),
                  disabledBorder: const UnderlineInputBorder(),
                ),
                onTap: onTap,
                readOnly: true,
                keyboardType: TextInputType.none,
              )
            : TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText ?? "input $title",
                  hintStyle: TextStyle(
                    color: AssetColor.grey.withOpacity(0.5),
                    fontFamily: "Jost",
                    fontWeight: FontWeight.normal,
                  ),
                  suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
                  border: const UnderlineInputBorder(),
                ),
                keyboardType: inputType,
                readOnly: readOnly,
                enabled: enabled,
                onChanged: (value) => onTyping!(value) ?? () {},
              ),
      ],
    );
  }
}
