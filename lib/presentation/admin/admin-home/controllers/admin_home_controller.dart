import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum AHomeState{
  loading,
  loaded,
  error,
  empty
}
class AdminHomeController extends GetxController{
  var store = Get.find<LocalStorageService>();
  var ahomeState = AHomeState.loading.obs;
  @override
  void onInit() {
    ahomeState.value = AHomeState.loaded;
    super.onInit();
  }
}