import 'dart:async';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/presentation/home/pages/home.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';

enum HomeState {
  loading,
  loaded,
  error,
}

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  var store = Get.find<LocalStorageService>();
}
 




 // final PageController _pagesController = PageController(initialPage: 0);

  // Timer? _timer;

  // late List<Widget?> _pages;
  // List<Widget?> get pages => _pages;
  // PageController get pagesController => _pagesController;

  // void startTime() {
  //   _timer = Timer.periodic(Duration(seconds: 3), (timer) {
  //     int nextPage = (_pagesController.page!.toInt() + 1) % imagePaths.length;
  //     _pagesController.animateToPage(nextPage,
  //         duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  //   });
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   _pages = List.generate(
  //       imagePaths.length,
  //       (index) => ImagePlaceholder(
  //             imagePath: imagePaths[index],
  //           ));
  //   startTime();
  // }