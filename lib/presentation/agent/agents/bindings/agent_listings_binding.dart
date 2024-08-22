import 'package:get/get.dart';
import '../controllers/agent_listings_controller.dart';

class AgentListingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentListingsController());
  }
}