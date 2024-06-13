import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';

class TabletAuthentication extends StatelessWidget {
  const TabletAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: IMPLEMENT TABLET LAYOUT
    // final controller = Get.put(AuthController());

    return const Scaffold(
      body: Center(
        child: CustomText("Tablet Authentication Page"),
      ),
    );
  }
}
