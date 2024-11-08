import 'package:eraphilippines/presentation/website/projects/controllers/project_list_controller.dart';
import 'package:eraphilippines/presentation/website/projects/controllers/projects_controller.dart';
import 'package:get/get.dart';

class ProjectsWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectsWebController());
    Get.lazyPut(() => ProjectsListWebController());
  }
}
