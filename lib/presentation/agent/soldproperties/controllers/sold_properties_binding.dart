import 'package:eraphilippines/presentation/agent/soldproperties/controllers/sold_properties_controller.dart';
import 'package:get/get.dart';
import '../../authentication/controllers/authentication_controller.dart';

class SoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SoldPropertiesController());
  }
}
