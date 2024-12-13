import 'package:get/get.dart';

import '../../../../website/listings/pages/add-edit_listings/controllers/addlistings_controller.dart';

class AddListingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddListingsController());
  }
}
