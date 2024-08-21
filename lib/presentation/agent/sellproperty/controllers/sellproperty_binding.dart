import 'package:eraphilippines/presentation/agent/sellproperty/controllers/sellproperty_controller.dart';
import 'package:get/get.dart';
import '../../authentication/controllers/authentication_controller.dart';

class SellPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SellPropertyController());
  }
}
