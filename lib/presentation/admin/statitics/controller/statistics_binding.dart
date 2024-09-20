import 'package:eraphilippines/presentation/admin/statitics/controller/statistics_controller.dart';
import 'package:get/get.dart';

class StatisticsBindinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticsController());
  }
}
