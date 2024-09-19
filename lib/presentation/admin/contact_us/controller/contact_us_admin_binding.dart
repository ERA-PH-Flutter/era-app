import 'package:eraphilippines/presentation/admin/contact_us/controller/contact_us_admin_controller.dart';
import 'package:get/get.dart';

class ContactUsABinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsAController());
  }
}
