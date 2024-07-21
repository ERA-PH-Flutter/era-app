import 'package:eraphilippines/presentation/agents/controllers/agents_controller.dart';
import 'package:get/get.dart';

class AgentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentsController());
  }
}
