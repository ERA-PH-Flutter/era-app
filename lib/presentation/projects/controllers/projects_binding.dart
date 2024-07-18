import 'package:eraphilippines/presentation/projects/controllers/projects_controller.dart';
import 'package:get/get.dart';
import '../../authentication/controllers/login_page_controller.dart';

class ProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectsController());
  }
}
