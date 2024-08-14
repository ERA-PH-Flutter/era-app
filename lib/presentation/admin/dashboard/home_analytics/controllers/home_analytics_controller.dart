import 'package:eraphilippines/app/services/local_storage.dart';
import 'package:get/get.dart';

enum AHomeState { loading, loaded, error, empty }

class HomeAnalyticsController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var ahomeState = AHomeState.loading.obs;
  @override
  void onInit() {
    ahomeState.value = AHomeState.loaded;
    super.onInit();
  }
}
