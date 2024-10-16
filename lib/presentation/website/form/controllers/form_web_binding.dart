import 'package:eraphilippines/presentation/website/form/controllers/form_web_controller.dart';
import 'package:get/get.dart';

class FormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FormWebController());
  }
}
