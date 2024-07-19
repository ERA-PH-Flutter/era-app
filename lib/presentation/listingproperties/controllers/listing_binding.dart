import 'package:eraphilippines/presentation/listingproperties/controllers/listing_controller.dart';
import 'package:get/get.dart';

class ListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListingController());
  }
}
