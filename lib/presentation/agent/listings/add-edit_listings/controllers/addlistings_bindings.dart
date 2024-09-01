import 'package:get/get.dart';
import 'addlistings_controller.dart';
 
class AddListingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddListingsController());
  }
}
