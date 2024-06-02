import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class GradationBackground extends StatelessWidget {
  const GradationBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AssetColor.blueTertiaryAccent,
            AssetColor.blueSecondaryAccent,
            AssetColor.bluePrimaryAccent,
          ],
        ),
      ),
    );
  }
}
