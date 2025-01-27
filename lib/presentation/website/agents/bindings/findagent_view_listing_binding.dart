import 'package:eraphilippines/presentation/website/agents/controllers/agent_myListingWeb_controller.dart';
import 'package:get/get.dart';

 

class FindagentViewListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentListingsWebController());
  }
}
