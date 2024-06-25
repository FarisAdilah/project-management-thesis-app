import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/button/custom_button.dart';
import 'package:project_management_thesis_app/globalComponent/createForm/client/controller_select_client.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class TabletSelectClient extends StatelessWidget {
  final ClientDM? initialClient;
  final Function(ClientDM) onClientSelected;

  const TabletSelectClient({
    super.key,
    this.initialClient,
    required this.onClientSelected,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectClientController(
      selectedClient: initialClient,
    ));

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AssetColor.whiteBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      height: MediaQuery.sizeOf(context).height * 0.75,
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomText(
                "Select Client",
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(FontAwesomeIcons.xmark),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AssetColor.greyBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(FontAwesomeIcons.magnifyingGlass),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Client",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.clients.length,
                itemBuilder: (context, index) {
                  ClientDM client = controller.clients[index];

                  return InkWell(
                    onTap: () => controller.setClientSelected(index),
                    child: Obx(
                      () => Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AssetColor.whiteBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: controller.selectedIndex.value == index
                                ? AssetColor.orangeButton
                                : AssetColor.greyBackground,
                          ),
                        ),
                        child: ListTile(
                          title: CustomText(
                            client.name ?? "",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: CustomText(
                            client.email ?? "",
                            fontSize: 16,
                          ),
                          trailing: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: AssetColor.whiteBackground,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: controller.selectedIndex.value == index
                                    ? AssetColor.orangeButton
                                    : AssetColor.grey,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: controller.selectedIndex.value == index
                                      ? AssetColor.orangeButton
                                      : AssetColor.whiteBackground,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: CustomButton(
              text: "Choose Client",
              color: AssetColor.orangeButton,
              onPressed: () {
                onClientSelected(
                  controller.clients[controller.selectedIndex.value],
                );
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }
}
