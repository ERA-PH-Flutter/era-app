import 'package:eraphilippines/presentation/website/re_route/re_route_args.dart';
import 'package:get/get.dart';

enum ReRouteState {loading,loaded,error}

class ReRouteController extends GetxController{
  var reRouteState = ReRouteState.loading.obs;
  ReRouteArgs? args;
  @override
  void onInit() {
    super.onInit();
    args = Get.arguments;
  }
}