 import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:get/get.dart';

class LandingpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandingPageController());
  }
}
