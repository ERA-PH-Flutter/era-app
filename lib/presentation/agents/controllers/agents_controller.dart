import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';

enum AgentsState {
  loading,
  loaded,
  error,
}

class AgentsController extends GetxController {
  var store = Get.find<LocalStorageService>();
}
