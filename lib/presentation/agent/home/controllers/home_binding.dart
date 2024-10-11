import 'package:eraphilippines/presentation/admin/properties/controllers/project_list_controller.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProjectsListController());
    Get.lazyPut(() => SearchResultController());
    Get.lazyPut(() => AgentsController());
  }
}
