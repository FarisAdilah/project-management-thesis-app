import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/homePage/component/menu_list.dart';
import 'package:project_management_thesis_app/pages/homePage/controller_home_page.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    return Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     'HomePage',
        //     style: TextStyle(color: AssetColor.whitePrimary),
        //   ),
        //   iconTheme: const IconThemeData(color: AssetColor.whitePrimary),
        //   backgroundColor: AssetColor.blueTertiaryAccent,
        //   centerTitle: true,
        //   actions: [
        //     TextButton.icon(
        //       onPressed: () => controller.logout(),
        //       icon: const Icon(
        //         FontAwesomeIcons.arrowRightFromBracket,
        //         color: AssetColor.whitePrimary,
        //       ),
        //       label: const Text(
        //         'Logout',
        //         style: TextStyle(
        //           color: AssetColor.whitePrimary,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // drawer: const Drawer(
        //   child: MenuList(),
        // ),
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
                      const MenuList(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text("Ini Halaman Untuk Semua Data"),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => ListView.builder(
                          itemCount: controller.users.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            UserDM user = controller.users[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              color: Colors.grey[300],
                              child: ListTile(
                                title: Text("${user.name}"),
                                subtitle: Text("Role: ${user.role}"),
                                onTap: () {
                                  Helpers().showSuccessSnackBar("${user.id}");
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.showCreateForm();
          },
          child: const Icon(Icons.add),
        ));
  }
}
