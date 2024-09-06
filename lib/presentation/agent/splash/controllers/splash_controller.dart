import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../app/models/settings.dart';
import '../../../../app/services/firebase_database.dart';
import '../../../../app/services/local_storage.dart';

enum SplashState {
  loaded,
  loading,
  error,
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
    super.onInit();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    settings = Settings.fromJSON(await Database().getSettings());
    if (user != null) {
      user = await EraUser().getById(user!.id);
    }
    _typeWrittingAnimation();
    await isReady.future;
    await Future.delayed(const Duration(seconds: 1));
    if (FirebaseAuth.instance.currentUser != null) {
      user = await EraUser().getById(FirebaseAuth.instance.currentUser!.uid);
    }
    var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;
    kIsWeb
        ? Get.toNamed(RouteString.landingPage) //admingLogin
        : shortestSide < 600
            ? Get.to(BaseScaffold())
            : Get.to(BaseScaffold());
  }
}
