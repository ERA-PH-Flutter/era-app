import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';

enum LoginPageState {
  loading,
  loaded,
  error,
}

class LoginPageController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var text = "".obs;
}


