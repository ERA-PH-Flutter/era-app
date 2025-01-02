 import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/listing_approval_controller.dart';
import 'package:eraphilippines/presentation/admin/statitics/controller/statistics_controller.dart';
import 'package:get/get.dart';

class LandingpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandingPageController());
    Get.lazyPut(() => StatisticsController());
    Get.lazyPut(() => ListingApprovalController());
  }
}
