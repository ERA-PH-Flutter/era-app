import 'package:get/get.dart';
import 'agents-admin_controller.dart';

class AgentsAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentsAdminController());
  }
}
