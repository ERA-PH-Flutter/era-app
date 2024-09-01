import 'package:get/get.dart';
import 'archived_controller.dart';

class ArchivedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArchivedController());
  }
}
