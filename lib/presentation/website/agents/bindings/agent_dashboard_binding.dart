import 'package:eraphilippines/presentation/website/agents/controllers/agent_dashboard_controller.dart';
import 'package:get/get.dart';

import '../controllers/agent_myListingWeb_controller.dart';

class AgentDashboardWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentListingsWebController());
    Get.lazyPut(() => AgentDashboardWebController());
  }
}
