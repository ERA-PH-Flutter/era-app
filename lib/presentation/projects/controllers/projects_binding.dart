import 'package:eraphilippines/presentation/projects/controllers/projects_controller.dart';
import 'package:get/get.dart';

class ProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectsController());
  }
}
