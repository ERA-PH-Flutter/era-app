import 'package:get/get.dart';
import 'contacts_controller.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactusController());
  }
}
