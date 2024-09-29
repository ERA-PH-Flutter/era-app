import 'package:eraphilippines/presentation/website/home_website/controllers/home_web_controller.dart';
import 'package:get/get.dart';

class HomeWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeWebController());
  }
}
