import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/website/agents/controllers/agents_controller.dart';
import 'package:get/get.dart';

class AgentListingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentsWebController());
  }
}
