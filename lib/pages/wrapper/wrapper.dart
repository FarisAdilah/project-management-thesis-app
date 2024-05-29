import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/authentication/mobile_authentication.dart';
import 'package:project_management_thesis_app/pages/authentication/tablet_authentication.dart';
import 'package:project_management_thesis_app/pages/authentication/web_authentication.dart';
import 'package:project_management_thesis_app/pages/homePage/mobile_home_page.dart';
import 'package:project_management_thesis_app/pages/homePage/tablet_home_page.dart';
import 'package:project_management_thesis_app/pages/homePage/web_home_page.dart';
import 'package:project_management_thesis_app/pages/responsive_layout.dart';
import 'package:project_management_thesis_app/pages/wrapper/controller_wrapper.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  final controller = Get.put(WrapperController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.user,
      builder: (context, snapshot) {
        Helpers.writeLog("snapshot: $snapshot");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return const ResponsiveLayout(
              mobileScaffold: MobileHomePage(),
              tabletScaffold: TabletHomePage(),
              desktopScaffold: WebHomePage(),
            );
          } else {
            return const ResponsiveLayout(
              mobileScaffold: MobileAuthentication(),
              tabletScaffold: TabletAuthentication(),
              desktopScaffold: WebAuthentication(),
            );
          }
        }
      },
    );
  }
}
