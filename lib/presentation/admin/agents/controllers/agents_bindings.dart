import 'package:get/get.dart';
import 'agents_controller.dart';

class AgentAdminBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentAdminController());
  }
}
