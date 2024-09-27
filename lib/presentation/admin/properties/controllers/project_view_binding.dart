import 'package:eraphilippines/presentation/admin/properties/controllers/project_view_controller.dart';
import 'package:get/get.dart';

class ProjectViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectViewController());
  }
}