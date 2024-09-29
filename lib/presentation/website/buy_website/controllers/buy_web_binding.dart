import 'package:eraphilippines/presentation/website/buy_website/controllers/buy_web_controller.dart';
import 'package:get/get.dart';

class BuyWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BuyWebController());
  }
}
