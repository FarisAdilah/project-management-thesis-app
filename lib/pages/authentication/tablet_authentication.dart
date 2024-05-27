import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/authentication/controller_auth.dart';

class TabletAuthentication extends StatelessWidget {
  const TabletAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return const Scaffold(
      body: Center(
        child: Text("Tablet Authentication Page"),
      ),
    );
  }
}
