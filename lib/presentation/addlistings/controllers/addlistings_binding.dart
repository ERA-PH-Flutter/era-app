import 'package:eraphilippines/presentation/addlistings/controllers/addlistings_controller.dart';
import 'package:get/get.dart';
import '../../authentication/controllers/authentication_controller.dart';

class AddListingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddListingsController());
  }
}
