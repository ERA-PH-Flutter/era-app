import 'package:get/get.dart';
import '../../login_page/controllers/login_page_controller.dart';

class SecondPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPageController());
  }
}
