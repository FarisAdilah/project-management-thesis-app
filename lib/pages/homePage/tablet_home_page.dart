import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class TabletHomePage extends StatelessWidget {
  const TabletHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: IMPLEMENT TABLET LAYOUT
    // final controller = Get.put(HomePageController());

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'HomePage',
          color: AssetColor.whitePrimary,
        ),
        backgroundColor: Colors.grey[900],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[300],
        child: const Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CustomText("Test")
          ],
        ),
      ),
    );
  }
}
