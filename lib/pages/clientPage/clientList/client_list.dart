import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/loading/loading.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientList/controller_client_list.dart';
import 'package:project_management_thesis_app/pages/clientPage/component/client_item_content.dart';

class ClientList extends StatelessWidget {
  const ClientList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClientListController());

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    const CustomText("Ini Halaman Untuk Data Client"),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => ListView.builder(
                        itemCount: controller.clients.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var client = controller.clients[index];

                          return ClientItemContent(client: client);
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
