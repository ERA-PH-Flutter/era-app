import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum SoldState{
  loading,
  loaded,
  error,
  empty
}
class SoldPropertiesController extends GetxController{
  var store = Get.find<LocalStorageService>();
  var soldState = SoldState.loading.obs;
  @override
  void onInit() {
    soldState.value = SoldState.loaded;
    super.onInit();
  }
}