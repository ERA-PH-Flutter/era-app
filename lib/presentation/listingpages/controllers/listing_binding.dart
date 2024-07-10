import 'package:eraphilippines/presentation/listingpages/controllers/listing_controller.dart';
import 'package:get/get.dart';
import '../../login_page/controllers/login_page_controller.dart';

class ListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListingController());
  }
}
