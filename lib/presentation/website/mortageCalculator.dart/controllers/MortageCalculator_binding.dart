import 'package:eraphilippines/presentation/website/mortageCalculator.dart/controllers/MortageCalculator_controller.dart';
import 'package:get/get.dart';

class MortageCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MortageCalculatorWController());
  }
}
