import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';

enum BaseState{
  loading,
  loaded,
  error,
  empty
}
class BaseController extends GetxController{
  var store = Get.find<LocalStorageService>();
  var baseState = BaseState.loading.obs;
  @override
  void onInit() {
    baseState.value = BaseState.loaded;
    super.onInit();
  }
}