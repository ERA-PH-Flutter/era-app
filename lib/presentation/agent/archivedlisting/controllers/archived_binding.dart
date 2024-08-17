import 'package:eraphilippines/presentation/agent/archivedlisting/controllers/archived_controller.dart';
import 'package:get/get.dart';

class ArchivedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArchivedController());
  }
}
