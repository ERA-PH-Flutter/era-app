import 'package:get/get.dart';

import '../controllers/agents_controller.dart';

class AgentWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentsWebController());
  }
}
