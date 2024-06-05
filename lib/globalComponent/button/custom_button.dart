import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Color? color;
  final Color? disableColor;
  final Color? textColor;
  final bool? isEnabled;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;

  const CustomButton({
    super.key,
    this.onPressed,
    this.text,
    this.color,
    this.disableColor,
    this.textColor,
    this.isEnabled,
    this.borderRadius,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed != null ? () => onPressed!() : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isEnabled ?? true
              ? color ?? AssetColor.blueSecondaryAccent
              : disableColor ?? AssetColor.bluePrimaryAccent,
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          boxShadow: boxShadow,
        ),
        child: CustomText(
          text ?? 'Button',
          color: textColor ?? AssetColor.whitePrimary,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
