import 'package:eraphilippines/presentation/website/landingpage/controllers/web_landingpage_controller.dart';
import 'package:get/get.dart';

class WebLandingpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebLandingPageController());
  }
}
