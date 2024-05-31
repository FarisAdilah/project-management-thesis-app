import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_management_thesis_app/globalComponent/avatar/profile_picture.dart';
import 'package:project_management_thesis_app/globalComponent/card/count_card.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/controller_main_page.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainPageController());

    return Container(
      color: AssetColor.greyBackground,
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Welcom, Search Bar, Profile Picture)
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => CustomText(
                        "Welcome, ${controller.currentUser.value.name ?? ''}!",
                        fontSize: 30,
                        color: AssetColor.blueSecondaryAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const CustomText(
                      "Let's manage your project here",
                      fontSize: 20,
                      color: AssetColor.blueTertiaryAccent,
                    )
                  ],
                ),
              ),
              const Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: SearchBar(
                    backgroundColor:
                        MaterialStatePropertyAll(AssetColor.whiteBackground),
                    overlayColor:
                        MaterialStatePropertyAll(AssetColor.whitePrimary),
                    surfaceTintColor:
                        MaterialStatePropertyAll(AssetColor.whiteBackground),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                    hintText: "Search your project here...",
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(
                    () => ProfilePicture(
                      user: controller.currentUser.value,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          const CustomText(
            "General Summary",
            color: AssetColor.blueTertiaryAccent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CountCard(
                    title: "Total Staff",
                    countItem: controller.users.length,
                    icon: FontAwesomeIcons.users,
                    margin: const EdgeInsets.only(right: 20),
                  ),
                ),
                const Expanded(
                  child: CountCard(
                    countItem: 10,
                    title: "Total Project",
                    icon: FontAwesomeIcons.solidFolderOpen,
                    margin: EdgeInsets.only(right: 20),
                  ),
                ),
                Expanded(
                  child: CountCard(
                    countItem: controller.vendors.length,
                    title: "Total Vendor",
                    icon: FontAwesomeIcons.userGear,
                    margin: const EdgeInsets.only(right: 20),
                  ),
                ),
                Expanded(
                  child: CountCard(
                    countItem: controller.clients.length,
                    title: "Total Client",
                    icon: FontAwesomeIcons.userTie,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const CustomText(
            "List Project",
            color: AssetColor.blueTertiaryAccent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: AssetColor.whiteBackground,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  "All Projects",
                  color: AssetColor.blackPrimary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildRow(
                  "Project Name",
                  "Client",
                  "Start Date",
                  "End Date",
                  "Status",
                ),
                ListView.builder(
                  itemCount: controller.projects.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ProjectDM project = controller.projects[index];

                    return _buildRow(
                      project.name ?? "name",
                      project.client?.name ?? "client",
                      project.startDate ?? "start date",
                      project.endDate ?? "end date",
                      project.status ?? "status",
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildRow(String name, String client, String startDate, String endDate,
    String status) {
  return Column(
    children: [
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildCell(name),
          ),
          Expanded(
            flex: 2,
            child: _buildCell(client),
          ),
          Expanded(
            flex: 1,
            child: _buildCell(startDate),
          ),
          Expanded(
            flex: 1,
            child: _buildCell(endDate),
          ),
          Expanded(
            flex: 2,
            child: _buildCell(status),
          ),
        ],
      ),
      const SizedBox(height: 8),
      const Divider(
        color: AssetColor.grey,
        thickness: 1,
      ),
    ],
  );
}

Widget _buildCell(String title) {
  return CustomText(
    title,
    color: AssetColor.grey,
    fontSize: 20,
  );
}
