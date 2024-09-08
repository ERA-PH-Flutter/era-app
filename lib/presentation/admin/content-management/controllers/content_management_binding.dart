import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';
import 'package:get/get.dart';

class ContentManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContentManagementController());
  }
}
