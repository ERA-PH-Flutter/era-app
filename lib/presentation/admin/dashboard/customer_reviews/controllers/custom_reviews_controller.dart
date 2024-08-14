import 'package:eraphilippines/app/services/local_storage.dart';
import 'package:get/get.dart';

enum CustomerReviewsState { loading, loaded, error, empty }

class CustomReviewsController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var ahomeState = CustomerReviewsState.loading.obs;
  @override
  void onInit() {
    ahomeState.value = CustomerReviewsState.loaded;
    super.onInit();
  }
}
