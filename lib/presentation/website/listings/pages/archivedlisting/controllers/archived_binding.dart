import 'package:eraphilippines/presentation/website/listings/pages/archivedlisting/controllers/archived_controller.dart';
import 'package:get/get.dart';
 
class ArchivedWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArchivedWebController());
  }
}
