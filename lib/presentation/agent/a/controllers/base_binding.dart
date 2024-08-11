import 'package:get/get.dart';
import '../../authentication/controllers/authentication_controller.dart';

class SecondPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPageController());
  }
}
