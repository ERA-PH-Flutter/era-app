import 'package:eraphilippines/presentation/admin/setting/contact_us/controller/contact_us_admin_controller.dart';
import 'package:eraphilippines/presentation/admin/setting/log_list/controller/log_list_admin_controller.dart';
import 'package:get/get.dart';

class LogListAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogListAdminController());
  }
}
