import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class CustomInputBorder extends StatelessWidget {
  final IconData? icon;
  final Color? borderColor;
  final TextEditingController? controller;
  final bool? isPassword;
  final bool? enabled;
  final VoidCallback? obscureCallback;
  final Function(String)? onChanged;

  const CustomInputBorder({
    super.key,
    this.icon,
    this.borderColor,
    this.controller,
    this.isPassword,
    this.enabled,
    this.obscureCallback,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword ?? false,
      enabled: enabled ?? true,
      onChanged: onChanged != null ? (value) => onChanged!(value) : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? AssetColor.grey,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? AssetColor.grey,
          ),
        ),
        fillColor:
            enabled ?? true ? AssetColor.whiteBackground : AssetColor.grey,
        filled: true,
        suffixIcon: icon != null
            ? InkWell(
                onTap: () => obscureCallback != null ? obscureCallback!() : {},
                child: Icon(
                  icon,
                  color: borderColor ?? AssetColor.grey,
                ),
              )
            : null,
      ),
    );
  }
}
