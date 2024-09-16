import 'package:eraphilippines/presentation/admin/faqs/controller/faqs_controller.dart';
import 'package:eraphilippines/presentation/admin/news/controller/new_controller.dart';
import 'package:get/get.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaqsController());
  }
}
