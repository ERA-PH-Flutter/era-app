import 'package:eraphilippines/presentation/agent/searchresult/controllers/searchresult_controller.dart';
import 'package:get/get.dart';
 
class SearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchResultController());
  }
}
