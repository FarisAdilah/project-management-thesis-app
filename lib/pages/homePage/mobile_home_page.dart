import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/menuList/mobile_menu_list.dart';
import 'package:project_management_thesis_app/pages/homePage/controller_home_page.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: IMPLEMENT MOBILE LAYOUT
    final controller = Get.put(HomePageController());

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.penToSquare,
              color: AssetColor.whiteBackground,
            ),
            SizedBox(width: 10),
            CustomText(
              'PenTools',
              fontSize: 16,
              color: AssetColor.whiteBackground,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        backgroundColor: AssetColor.blueDark,
        iconTheme: const IconThemeData(
          color: AssetColor.whiteBackground,
        ),
      ),
      drawer: Drawer(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            color: AssetColor.blueDark,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: const CustomText(
                  'PenTools',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AssetColor.whitePrimary,
                ),
              ),
              Obx(
                () => MobileMenuList(
                  menus: controller.menus.toList(),
                  onTapMenu: (menu) => controller.setSelectedMenu(menu),
                  selectedMenuId: controller.selectedMenuId.value,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => controller.logout(),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(10),
                  child: const Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        color: AssetColor.whitePrimary,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        'Logout',
                        color: AssetColor.whitePrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AssetColor.whitePrimary,
        ),
        child: Obx(
          () => controller.getSelectedMenuWidget(),
        ),
      ),
    );
  }
}
