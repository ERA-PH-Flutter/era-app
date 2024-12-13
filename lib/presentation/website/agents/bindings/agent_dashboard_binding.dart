import 'package:get/get.dart';

import '../controllers/agent_dashboard_controller.dart';
import '../controllers/agents_controller.dart';

class AgentDashboardWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentDashboardWebController());
  }
}
