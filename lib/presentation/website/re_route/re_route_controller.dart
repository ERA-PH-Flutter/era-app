import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:eraphilippines/presentation/website/re_route/re_route_args.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../router/route_arguments.dart';

enum ReRouteState {loading,loaded,error}

class ReRouteController extends GetxController{
  var reRouteState = ReRouteState.loading.obs;
  ReRouteArgs? args;
  ScrollController scrollController = ScrollController();
  var isNavbarVisible = true.obs;

  final Uri emailUrl = Uri.parse(
      'mailto:sales@eraphilippines.com?subject=Your%20Subject&body=Your%20Message');

  final Uri whatsappUrl = Uri.parse('https://wa.me/639177710572');

  final Uri facebook = Uri.parse(
      'https://www.facebook.com/profile.php?id=61556521950596&mibextid=wwXIfr&rdid=KQZJrEeFQYosVzxe&share_url=https%3A%2F%2Fwww.facebook.com%2Fshare%2F15W4JqJJRc%2F%3Fmibextid%3DwwXIfr#');
  final Uri instagram = Uri.parse('https://www.instagram.com/era_philippines/');
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