import 'package:eraphilippines/presentation/admin/dashboard/home_analytics/controllers/home_analytics_controller.dart';
import 'package:get/get.dart';

class HomeAnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeAnalyticsController());
  }
}
