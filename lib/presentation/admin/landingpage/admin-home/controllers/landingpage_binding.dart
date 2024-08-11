import 'package:eraphilippines/presentation/admin/landingpage/admin-home/controllers/landingpage_controller.dart';
import 'package:get/get.dart';

class LandingpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandingPageController());
  }
}
