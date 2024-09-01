import 'package:get/get.dart';

import 'fav_controller.dart';
 
class FavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavController());
  }
}
