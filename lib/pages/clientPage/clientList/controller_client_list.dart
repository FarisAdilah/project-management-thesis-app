import 'package:get/get.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';

class ClientListController extends GetxController {
  final _clientRepository = ClientRepository.instance;

  RxList<ClientDM> clients = <ClientDM>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getClientList();
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
}
