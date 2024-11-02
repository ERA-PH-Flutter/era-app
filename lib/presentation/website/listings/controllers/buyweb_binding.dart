import 'package:eraphilippines/presentation/website/listings/controllers/listings_web_controller.dart';
import 'package:get/get.dart';

class BuyWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListingsWebController());
  }
}
