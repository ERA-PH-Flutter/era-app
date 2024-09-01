import 'package:get/get.dart';
import 'MortageCalculator_controller.dart';

class MortageCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MortageCalculatorController());
  }
}
