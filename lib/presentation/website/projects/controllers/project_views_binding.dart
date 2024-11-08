import 'package:eraphilippines/presentation/website/projects/controllers/project_view_controller.dart';
import 'package:get/get.dart';

class ProjectViewWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectViewWebController());
  }
}
