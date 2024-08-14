import 'package:eraphilippines/presentation/admin/dashboard/customer_reviews/controllers/custom_reviews_controller.dart';
import 'package:get/get.dart';

class CustomerReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomReviewsController());
  }
}
