import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class Loading extends StatelessWidget {
  final double? height;
  final double? width;

  const Loading({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.sizeOf(context).height,
      width: width ?? MediaQuery.sizeOf(context).width,
      color: AssetColor.blackPrimary.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(
          color: AssetColor.bluePrimaryAccent,
        ),
      ),
    );
  }
}
