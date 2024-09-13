import 'package:eraphilippines/presentation/admin/properties/controllers/listingsAdmin_controller.dart';
import 'package:get/get.dart';

class ListingsAdminBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListingsAdminController());
  }
}
