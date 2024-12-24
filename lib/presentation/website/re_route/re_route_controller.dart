import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:eraphilippines/presentation/website/re_route/re_route_args.dart';
import 'package:get/get.dart';

import '../../../router/route_arguments.dart';

enum ReRouteState {loading,loaded,error}

class ReRouteController extends GetxController{
  var reRouteState = ReRouteState.loading.obs;
  ReRouteArgs? args;
  @override
  void onInit() {
    super.onInit();
    //args = Get.arguments;
    //args!.binding.dependencies();
    //reRouteState.value = ReRouteState.loaded;
  }
  // @override
  // void onReady() {
  //   print("ready");
  //   super.onInit();
  //   args = Get.arguments;
  //   args!.binding.dependencies();
  //   reRouteState.value = ReRouteState.loaded;
  // }
}

class ReRouteBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>HomsController());
    Get.lazyPut(()=>ReRouteController());
    var controller = Get.find<ReRouteController>();
    ReRouteArgs args = RouteArgs.getArgs(Get.currentRoute);
    args.binding.dependencies();
    controller.args = args;
    controller.reRouteState.value = ReRouteState.loaded;
  }
}