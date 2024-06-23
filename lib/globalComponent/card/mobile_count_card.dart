import 'package:flutter/widgets.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class MobileCountCard extends StatelessWidget {
  final int countItem;
  final String title;
  final IconData icon;
  final EdgeInsets? margin;

  const MobileCountCard({
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
        horizontal: 15,
      ),
      margin: margin,
      decoration: BoxDecoration(
        color: AssetColor.whiteBackground,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AssetColor.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5.0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: AssetColor.blueTertiaryAccent,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                countItem.toString(),
                fontSize: 30,
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 10),
              CustomText(
                title,
                fontSize: 20,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
