import 'package:eraphilippines/presentation/agent/listings/sellproperty/controllers/sellproperty_controller.dart';
import 'package:get/get.dart';

class SellPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SellPropertyController());
  }
}
