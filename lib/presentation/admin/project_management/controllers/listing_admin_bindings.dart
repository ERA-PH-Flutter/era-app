import 'package:eraphilippines/presentation/admin/project_management/controllers/listingsAdmin_controller.dart';
import 'package:get/get.dart';

class ListingAdminBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListingsAdminController());
  }
}
