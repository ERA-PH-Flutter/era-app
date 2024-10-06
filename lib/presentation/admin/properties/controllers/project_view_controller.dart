import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum ProjectViewState{
  loading,
  loaded,
  error,
  empty,
}
class ProjectViewController extends GetxController{
  var store = Get.find<LocalStorageService>();
  var projectViewState = ProjectViewState.loading.obs;
  @override
  void onInit() {
    projectViewState.value = ProjectViewState.loaded;
    super.onInit();
  }
}