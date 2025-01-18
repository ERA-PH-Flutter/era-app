import 'dart:async';

import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../app/models/settings.dart';
import '../../../../app/services/firebase_database.dart';
import '../../../../app/services/local_storage.dart';

enum SplashState {
  loaded,
  loading,
  error,
  web,
}

class SplashController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var splashState = SplashState.loading.obs;
  final List<String> strings = [
    'CONNECT WORLDS,\nBUILD DREAMS.',
  ];
  int currentIndex = 0;
  var currentCharIndex = 0.obs;
  Completer<bool> isReady = Completer();
  void _typeWrittingAnimation() {
    if (currentCharIndex < strings[currentIndex].length) {
      currentCharIndex++;
    } else {
      currentIndex = (currentIndex + 1) % strings.length;
      isReady.complete(true);
    }
    Future.delayed(const Duration(milliseconds: 60), () {
      !isReady.isCompleted ? _typeWrittingAnimation() : null;
    });
  }

  @override
  void onInit() async {
    if (FirebaseAuth.instance.currentUser != null) {
      user = await EraUser().getById(FirebaseAuth.instance.currentUser!.uid);
    }
    super.onInit();
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
    splashState.value = kIsWeb ? SplashState.web : SplashState.loading;
    settings = Settings.fromJSON(await Database().getSettings());
    if (user != null) {
      user = await EraUser().getById(user!.id);
    }
    // _typeWrittingAnimation();
    // await isReady.future;
    await Future.delayed(const Duration(milliseconds: 500));
    String currentRoute = Get.currentRoute;

    if (currentRoute == RouteString.privacyPolicy) {
      return;
    }
    Get.lazyPut(() => HomsController());
    //Get.toNamed('/home');
  }
}
