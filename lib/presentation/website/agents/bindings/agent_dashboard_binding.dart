import 'package:get/get.dart';

import '../controllers/agent_dashboard_controller.dart';

 
class AgentListingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentDashboardWebController());
  }
}
