import 'package:get/get.dart';
import 'package:project_management_thesis_app/pages/clientPage/clientAdd/client_add.dart';
import 'package:project_management_thesis_app/repository/client/client_repository.dart';
import 'package:project_management_thesis_app/repository/client/dataModel/client_dm.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
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

  setSelectedClient(int index) {
    selectedIndex.value = index;
    Helpers.writeLog("selectedClient: $selectedIndex");
  }

  showCreateForm() {
    Get.to(() => const ClientAdd())?.whenComplete(() => _getClientList());
  }
}
