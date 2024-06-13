import 'dart:convert';

import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class SelectClientController extends GetxController {
  final ClientRepository _clientRepo = ClientRepository.instance;

  RxBool isLoading = false.obs;
  RxInt selectedIndex = (-1).obs;

  RxList<ClientDM> clients = <ClientDM>[].obs;

  ClientDM? selectedClient;

  SelectClientController({this.selectedClient});

  @override
  void onInit() async {
    super.onInit();
    await getClients();
  }

  getClients() async {
    isLoading.value = true;
    clients.value = await _clientRepo.getAllClient();
    isLoading.value = false;

    Helpers.writeLog("clients: ${clients.length}");
    Helpers.writeLog("clients: ${jsonEncode(clients)}");

    selectedIndex.value =
        clients.indexWhere((element) => element.name == selectedClient?.name);

    Helpers.writeLog("selectedIndex: ${selectedIndex.value}");
  }

  setClientSelected(int index) {
    selectedIndex.value = index;
  }
}
