import 'package:eraphilippines/presentation/admin/trainings/controller/trainings_controller.dart';
import 'package:get/get.dart';

class TrainingAdminBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainingController());
  }
}
