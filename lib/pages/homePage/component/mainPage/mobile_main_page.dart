import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/avatar/profile_picture.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/card/mobile_count_card.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/controller_main_page.dart';
import 'package:project_management_thesis_app/pages/homePage/component/mainPage/subComponent/mobile_project_content.dart';
import 'package:project_management_thesis_app/repository/project/dataModel/project_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class MobileMainPage extends StatelessWidget {
  const MobileMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainPageController());

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Container(
              height: double.infinity,
              color: AssetColor.greyBackground,
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header (Welcom, Search Bar, Profile Picture)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => CustomText(
                                    "Welcome, ${controller.currentUser.value.name ?? ''}!",
                                    fontSize: 24,
                                    color: AssetColor.blueSecondaryAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const CustomText(
                                  "Let's manage your project here",
                                  fontSize: 20,
                                  color: AssetColor.blueTertiaryAccent,
                                ),
                              ],
                            ),
                            Obx(
                              () => ProfilePicture(
                                user: controller.currentUser.value,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SearchBar(
                          leading: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: AssetColor.blueTertiaryAccent,
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                              AssetColor.whiteBackground),
                          surfaceTintColor: WidgetStatePropertyAll(
                              AssetColor.whiteBackground),
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          ),
                          hintText: "Search your project here...",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // General Summary
                    const CustomText(
                      "General Summary",
                      color: AssetColor.blueTertiaryAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: MobileCountCard(
                                  title: "Staff",
                                  countItem: controller.users.length,
                                  icon: FontAwesomeIcons.users,
                                  margin: const EdgeInsets.only(bottom: 20),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: MobileCountCard(
                                  countItem: controller.projects.length,
                                  title: "Project",
                                  icon: FontAwesomeIcons.solidFolderOpen,
                                  margin: const EdgeInsets.only(bottom: 20),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: MobileCountCard(
                                  countItem: controller.vendors.length,
                                  title: "Vendor",
                                  icon: FontAwesomeIcons.userGear,
                                  margin: const EdgeInsets.only(bottom: 20),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: MobileCountCard(
                                  countItem: controller.clients.length,
                                  title: "Client",
                                  icon: FontAwesomeIcons.userTie,
                                  margin: const EdgeInsets.only(bottom: 20),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    controller.getPendingWidget(),
                    const CustomText(
                      "List Project",
                      color: AssetColor.blueTertiaryAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.currentUser.value.role == UserType.admin.name
                        ? CustomButton(
                            text: "Add New Project",
                            color: AssetColor.greenButton,
                            borderRadius: 8,
                            onPressed: () {
                              controller.createProject();
                            },
                          )
                        : const SizedBox(),
                    controller.currentUser.value.role == UserType.admin.name
                        ? const SizedBox(
                            height: 20,
                          )
                        : const SizedBox(),
                    Obx(
                      () => ListView.builder(
                        itemCount: controller.projects.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          ProjectDM project = controller.projects[index];

                          return InkWell(
                            onTap: () => controller.showProjectDetail(
                              project.id ?? "",
                            ),
                            child: MobileProjectContent(
                              project: project,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            controller.isLoading.value ? const Loading() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
