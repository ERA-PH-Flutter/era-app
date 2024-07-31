import 'package:carousel_slider/carousel_controller.dart';
import 'package:eraphilippines/app/models/navbaritems.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/presentation/utility/controller/base_controller.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../app/services/firebase_database.dart';
import '../../../app/services/local_storage.dart';

enum HomeState {
  loading,
  loaded,
  error,
}

class HomeController extends GetxController{
  var selectedIndex = 0.obs;
  var carouselIndex = 0.obs;
  var selectedLocation = ''.obs;
  var selectedPropertyType = ''.obs;
  var selectedPriceRange = ''.obs;
  var isForSale = 0.obs;
  var isForLease = true.obs;
  var innerController = CarouselController();
  var carouselC = PageController();

  TextEditingController locationController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController aiSearchController = TextEditingController();

  void nextImage(int totalImg) {
    if (carouselIndex.value < totalImg - 1) {
      carouselIndex.value++;
    }
  }

  void prevImage() {
    if (carouselIndex.value > 0) {
      carouselIndex.value--;
    }
  }

  void changeIndex(int index) {
    navBarItems[index].onTap?.call();
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed('/home');
        break;
      case 1:
        Get.toNamed('/project-main');
        break;
      case 2:
        Get.toNamed('/searchresult');
        break;
      case 3:
        Get.toNamed('/findagents');
        break;
      case 4:
        Get.toNamed('/help');
        break;
    }
  }

  search()async{

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