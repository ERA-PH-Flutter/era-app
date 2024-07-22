import 'package:eraphilippines/app/models/navbaritems.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';

enum HomeState {
  loading,
  loaded,
  error,
}

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  TextEditingController locationController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController aiSearchController = TextEditingController();
  var radioVal = true.obs;

  void changeIndex(int index) {
    navBarItems[index].onTap?.call();
    selectedIndex.value = index;
  }

  var currentTab = 0.obs;
  void changeTab(int index) {
    currentTab.value = index;
  }

  var store = Get.find<LocalStorageService>();

  static logout() {
    Authentication().logout();
    Get.offAllNamed(RouteString.loginpage);
  }
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