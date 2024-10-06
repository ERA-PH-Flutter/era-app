import 'package:eraphilippines/presentation/admin/setting/sell_property/controller/sell_property_controller.dart';
import 'package:get/get.dart';

class SellPropertyABindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SellPropertyAController());
  }
}
