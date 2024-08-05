import 'package:eraphilippines/presentation/add-edit_listings/controllers/addlistings_controller.dart';
 import 'package:get/get.dart';
 
class AddListingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddListingsController());
  }
}
