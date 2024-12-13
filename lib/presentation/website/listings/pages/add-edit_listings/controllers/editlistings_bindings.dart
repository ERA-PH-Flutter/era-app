import 'package:get/get.dart';
import '../../../../../agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'listing_web_controller.dart';

class EditListingsBinding extends Bindings {
  @override
  void dependencies() {
    //   Get.lazyPut(() => ListingsController());
    Get.lazyPut(() => AddListingsController());
  }
}
