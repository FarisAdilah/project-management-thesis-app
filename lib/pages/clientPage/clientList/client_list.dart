import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientList/controller_client_list.dart';
import 'package:project_management_thesis_app/pages/clientPage/component/client_detail.dart';
import 'package:project_management_thesis_app/pages/clientPage/component/client_item_content.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class ClientList extends StatelessWidget {
  const ClientList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClientListController());

    // IMPLEMENT EDIT & UPDATE UI
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              color: AssetColor.greyBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Client List",
                    fontSize: 36,
                    color: AssetColor.blackPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: AssetColor.grey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  controller.currentUser?.role == UserType.admin.name
                      ? Column(
                          children: [
                            CustomButton(
                              onPressed: () => controller.showCreateForm(),
                              text: "Add New Client",
                              color: AssetColor.greenButton,
                              borderRadius: 8,
                              boxShadow: [
                                BoxShadow(
                                  color: AssetColor.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.65,
                      ),
                      shrinkWrap: true,
                      itemCount: controller.clients.length,
                      itemBuilder: (context, index) {
                        var client = controller.clients[index];

                        return ClientItemContent(
                          client: client,
                          onPressed: () {
                            controller.setSelectedClient(index);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.selectedIndex.value != -1,
                child: ClientDetail(
                  client: controller.selectedIndex.value != -1
                      ? controller.clients[controller.selectedIndex.value]
                      : ClientDM(),
                  onClose: () {
                    controller.setSelectedClient(-1);
                  },
                  onEditClient: (client) {
                    controller.showEditForm(client);
                  },
                  onDeleteClient: (client) {
                    controller.onDeleteClient(client);
                  },
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
