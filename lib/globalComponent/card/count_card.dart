import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class CountCard extends StatelessWidget {
  final int countItem;
  final String title;
  final IconData icon;
  final EdgeInsets? margin;

  const CountCard({
    super.key,
    required this.countItem,
    required this.title,
    required this.icon,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 35,
      ),
      margin: margin,
      decoration: BoxDecoration(
        color: AssetColor.whiteBackground,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 40,
            color: AssetColor.blueTertiaryAccent,
          ),
          const SizedBox(width: 30),
          Column(
            children: [
              CustomText(
                countItem.toString(),
                fontSize: 30,
              ),
              CustomText(
                title,
                fontSize: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
