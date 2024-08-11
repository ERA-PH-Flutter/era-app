import 'package:eraphilippines/presentation/admin/admin-home/controllers/admin_home_controller.dart';
import 'package:get/get.dart';

class AdminHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminHomeController());
  }
}
