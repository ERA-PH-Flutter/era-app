import 'package:get/get.dart';
import '../controllers/agents_controller.dart';

class AgentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgentsController());
  }
}
