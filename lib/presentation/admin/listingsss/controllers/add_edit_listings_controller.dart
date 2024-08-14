import 'package:eraphilippines/app/services/local_storage.dart';
import 'package:get/get.dart';

enum AddEditListingsState { loading, loaded, error, empty }

class AddEditListingsController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var addEditListings = AddEditListingsState.loading.obs;
  @override
  void onInit() {
    addEditListings.value = AddEditListingsState.loaded;
    super.onInit();
  }
}
