import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:get/get.dart';

class HomsWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomsController());
  }
}
