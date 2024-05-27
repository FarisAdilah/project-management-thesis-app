import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/homePage/component/menu_list.dart';
import 'package:project_management_thesis_app/pages/homePage/controller_home_page.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: AssetColor.whitePrimary,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: AssetColor.blueTertiaryAccent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: const Text(
                          'PenTools',
                          style: TextStyle(
                            color: AssetColor.whitePrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Obx(
                        () => MenuList(
                          menus: controller.menus.toList(),
                          onTapMenu: (menu) => controller.setSelectedMenu(menu),
                          selectedMenuId: controller.selectedMenuId.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                  flex: 5,
                  child: controller.getSelectedMenuWidget(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // controller.showCreateForm();
            controller.logout();
          },
          child: const Icon(
            FontAwesomeIcons.arrowRightFromBracket,
          ),
        ));
  }
}
