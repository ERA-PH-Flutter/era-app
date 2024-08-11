import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum MortageCalculatorState {
  loading,
  loaded,
  error,
}

class MortageCalculatorController extends GetxController {
  var store = Get.find<LocalStorageService>();
}
