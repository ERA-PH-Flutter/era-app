import 'package:get/get.dart';
import 'companynews_controller.dart';

class CompanyNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyNewsController());
  }
}
