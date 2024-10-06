import 'package:eraphilippines/presentation/admin/properties/controllers/project_list_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_controller.dart';
import 'package:get/get.dart';

class ProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectsController());
    Get.lazyPut(() => ProjectsListController());
  }
}
