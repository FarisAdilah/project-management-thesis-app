import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientDetail/mobile_client_detail.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientForm/mobile_client_form.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientForm/tablet_client_form.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientForm/web_client_form.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientDetail/web_client_detail.dart';
import 'package:project_management_thesis_app/pages/responsive_layout.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/storage.dart';

class ClientListController extends GetxController with Storage {
  final _clientRepository = ClientRepository.instance;

  RxList<ClientDM> clients = <ClientDM>[].obs;

  RxBool isLoading = false.obs;
  RxInt selectedIndex = (-1).obs;

  UserDM? currentUser = UserDM();

  @override
  void onInit() async {
    super.onInit();
    currentUser = await getUserData();
    await _getClientList();
  }

  _getClientList() async {
    isLoading.value = true;

    var response = await _clientRepository.getAllClient();

    if (response.isNotEmpty) {
      clients.value = response;
    } else {
      Helpers().showErrorSnackBar("Failed to get client data");
    }

    isLoading.value = false;
  }

  showCreateForm() {
    Get.to(
      () => const ResponsiveLayout(
        mobileScaffold: MobileClientForm(),
        tabletScaffold: TabletClientForm(),
        desktopScaffold: WebClientForm(),
      ),
    )?.whenComplete(
      () => _getClientList(),
    );
  }

  showEditForm(ClientDM client) {
    Get.to(
      () => WebClientForm(
        client: client,
        isUpdate: true,
      ),
    )?.whenComplete(() {
      selectedIndex.value = -1;
      _getClientList();
    });
  }

  onDeleteClient(ClientDM client) {
    Get.dialog(
      AlertDialog(
        title: const CustomText(
          "Delete Vendor",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AssetColor.greyBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 16,
        ),
        content: CustomText(
          "Are you sure you want to delete ${client.name}?",
          fontSize: 18,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 16,
        ),
        actions: [
          TextButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AssetColor.orangeButton,
              ),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const CustomText(
              "Cancel",
              color: AssetColor.whiteBackground,
            ),
          ),
          TextButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                AssetColor.redButton,
              ),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
              ),
            ),
            onPressed: () {
              Get.back();
              selectedIndex.value = -1;
              _deleteClient(client);
            },
            child: const CustomText(
              "Delete",
              color: AssetColor.whiteBackground,
            ),
          ),
        ],
      ),
    );
  }

  _deleteClient(ClientDM client) async {
    isLoading.value = true;

    bool isDeleted = await _clientRepository.deleteClient(
      client.id ?? "",
      client.image ?? "",
    );

    if (isDeleted) {
      Helpers().showSuccessSnackBar("Client deleted successfully");
      _getClientList();
    } else {
      Helpers().showErrorSnackBar("Failed to delete client");
    }
  }

  showClientDetail(ClientDM client) {
    Get.dialog(
      ResponsiveLayout(
        mobileScaffold: AlertDialog(
          backgroundColor: AssetColor.greyBackground,
          contentPadding: const EdgeInsets.all(0),
          content: MobileClientDetail(
            client: client,
            onClose: () => Get.back(),
            onEditClient: (client) => showEditForm(client),
            onDeleteClient: (client) => onDeleteClient(client),
          ),
        ),
        tabletScaffold: AlertDialog(
          backgroundColor: AssetColor.greyBackground,
          contentPadding: const EdgeInsets.all(0),
          content: WebClientDetail(
            client: client,
            onClose: () => Get.back(),
            onEditClient: (client) => showEditForm(client),
            onDeleteClient: (client) => onDeleteClient(client),
          ),
        ),
        desktopScaffold: AlertDialog(
          backgroundColor: AssetColor.greyBackground,
          contentPadding: const EdgeInsets.all(0),
          content: WebClientDetail(
            client: client,
            onClose: () => Get.back(),
            onEditClient: (client) => showEditForm(client),
            onDeleteClient: (client) => onDeleteClient(client),
          ),
        ),
      ),
    );
  }
}
