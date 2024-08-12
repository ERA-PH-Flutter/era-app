import 'package:eraphilippines/presentation/admin/listings/add_edit_listings.dart/controllers/add_edit_listings_controller.dart';
import 'package:get/get.dart';

class AddEditListingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddEditListingsController());
  }
}
