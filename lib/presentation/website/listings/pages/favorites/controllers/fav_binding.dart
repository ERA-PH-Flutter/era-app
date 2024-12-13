import 'package:eraphilippines/presentation/website/listings/pages/favorites/controllers/fav_controller.dart';
import 'package:get/get.dart';

 
class FavWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavWebController());
  }
}
