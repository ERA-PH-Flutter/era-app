import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:get/get.dart';

import '../../../app/services/local_storage.dart';

enum SplashState {
  loaded,
  loading,
  error,
}

class SplashController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var splashState = SplashState.loading.obs;
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 5));
    if (Authentication().auth.currentUser == null) {
      Get.toNamed(RouteString.loginpage);
    } else {
      Get.toNamed(RouteString.home);
    }
  }
}
