import 'package:eraphilippines/presentation/agent/listings/listingproperties/controllers/findproperties_controller.dart';
import 'package:get/get.dart';

class FindPropertiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FindpropertiesController());
  }
}
