import 'package:get/get.dart';
import '../../authentication/controllers/login_page_controller.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsBinding());
  }
}
