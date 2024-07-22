import 'package:eraphilippines/presentation/companynews/controllers/companynews_controller.dart';
import 'package:get/get.dart';

class CompanyNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyNewsController());
  }
}
