import 'package:eraphilippines/presentation/agent/listings/sold_properties/controllers/sold_properties_controller.dart';
import 'package:get/get.dart';

class SoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SoldPropertiesController());
  }
}
