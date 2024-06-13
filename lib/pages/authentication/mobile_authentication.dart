import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';

class MobileAuthentication extends StatelessWidget {
  const MobileAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Implement MOBILE LAYOUT
    // final controller = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(title: const CustomText('Mobiles Authentication Page')),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        width: 150,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            elevation: 0,
          ),
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const MobileHomePage()));
          },
          child: const CustomText(
            "Log In",
          ),
        ),
      ),
    );
  }
}
