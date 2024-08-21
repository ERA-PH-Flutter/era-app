import 'package:eraphilippines/presentation/agent/contacts/controllers/contacts_controller.dart';
import 'package:get/get.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactusController());
  }
}
