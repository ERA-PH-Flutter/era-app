import 'package:eraphilippines/presentation/agent/favorites/controllers/fav_controller.dart';
import 'package:get/get.dart';
 
class FavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavController());
  }
}
