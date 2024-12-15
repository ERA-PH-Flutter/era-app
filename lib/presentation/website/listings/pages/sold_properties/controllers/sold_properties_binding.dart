 import 'package:eraphilippines/presentation/website/listings/pages/sold_properties/controllers/sold_properties_controller.dart';
import 'package:get/get.dart';

class SoldBindingWeb extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SoldPropertiesWebController());
  }
}
