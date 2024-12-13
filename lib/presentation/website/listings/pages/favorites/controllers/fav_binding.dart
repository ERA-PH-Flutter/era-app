import 'package:get/get.dart';

import 'fav_controller.dart';

class FavWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavWebController());
  }
}
