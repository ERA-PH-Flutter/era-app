import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

enum LandingState { loading, loaded, error, empty }

class LandingPageController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var landingState = LandingState.loading.obs;
  @override
  void onInit() {
    landingState.value = LandingState.loaded;
    super.onInit();
  }
}
