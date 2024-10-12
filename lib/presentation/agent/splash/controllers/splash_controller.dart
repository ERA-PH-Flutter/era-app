import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/quick_links.dart';
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
    super.onInit();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    splashState.value = kIsWeb ? SplashState.web : SplashState.loading;
    _typeWrittingAnimation();
    settings = Settings.fromJSON(await Database().getSettings());

    if((store.settings == null && !kIsWeb)){
      await loadLocalImage();
    }else if(settings!.id != store.settings!.id && !kIsWeb){
      await loadLocalImage();
    }
    if (user != null) {
      user = await EraUser().getById(user!.id);
    }

    await isReady.future;
    //await Future.delayed(const Duration(milliseconds: 500));
    if (FirebaseAuth.instance.currentUser != null) {
      user = await EraUser().getById(FirebaseAuth.instance.currentUser!.uid);
    }
    var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;
    kIsWeb && user != null
        ? Get.toNamed(RouteString.landingPage)
        : kIsWeb
            ? Get.toNamed(RouteString.adminLogin) //admingLogin
            : shortestSide < 600
                ? Get.offAndToNamed('/base')
                : Get.offAndToNamed('/base');
  }

  loadLocalImage()async{//delete old files
    // if(store.images != null){
    //   var images = store.images;
    //   for (var banner in images?['banners']) {
    //     await CloudStorage().deleteFile(banner);
    //   }
    //   for (var ql in images?['quick_links']) {
    //     await CloudStorage().deleteFile(ql);
    //   }
    //   await CloudStorage().deleteFile(images?['residential']);
    //   await CloudStorage().deleteFile(images?['auction']);
    //   await CloudStorage().deleteFile(images?['commercial']);
    //   await CloudStorage().deleteFile(images?['rental']);
    //   await CloudStorage().deleteFile(images?['pre_selling']);
    // }
    //load new files
    Map<String,dynamic> savedData = {
      "banners" : [],
      "quick_links" : [],
      "residential" : "",
      "auction" : "",
      "commercial" : "",
      "rental" : "",
      "pre_selling" : "",
    };
    //download carousel
    for (var banner in settings!.banners!) {
      savedData['banners'].add( await CloudStorage().downloadAndSave(docRef: banner,folder: 'banners'));
    }
    //download quickLinks
    savedData['quick_links'] = await QuickLinksModel().download();
    savedData['rental'] = ( await CloudStorage().downloadAndSave(docRef: settings!.rentalPicture!,folder: 'rental'));
    savedData['auction'] = ( await CloudStorage().downloadAndSave(docRef: settings!.auctionPicture!,folder: 'auction'));
    savedData['commercial'] = ( await CloudStorage().downloadAndSave(docRef: settings!.commercialPicture!,folder: 'commercial'));
    savedData['residential'] = ( await CloudStorage().downloadAndSave(docRef: settings!.residentialPicture!,folder: 'residential'));
    savedData['pre_selling'] = ( await CloudStorage().downloadAndSave(docRef: settings!.preSellingPicture!, folder: 'pre_selling'));
    store.images = savedData;
    store.settings = settings;
  }
}
