import 'package:get/get.dart';

import '../controllers/agent_myListingWeb_controller.dart';

class AgentListingsWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentListingsWebController());
  }
}
