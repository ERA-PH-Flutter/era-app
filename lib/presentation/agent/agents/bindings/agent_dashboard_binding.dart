import 'package:eraphilippines/presentation/agent/agents/controllers/agent_dashboard_controller.dart';
import 'package:get/get.dart';
 
class AgentDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentDashboardController());
  }
}