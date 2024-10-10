import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_controller.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/models/navbaritems.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/quick_links.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/models/propertieslisting.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/listing.dart';
import '../../../../repository/news.dart';
import '../../../../repository/project.dart';

enum HomeState {
  loading,
  loaded,
  error,
}

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var carouselIndex = 0.obs;
  var selectedLocation = ''.obs;
  var selectedPropertyType = ''.obs;
  var selectedPriceRange = ''.obs;
  var isForSale = 0.obs;
  var isForLease = true.obs;
  var innerController = CarouselSliderController();
  var carouselC = PageController();
  var homeState = HomeState.loading.obs;
  var news = [];
  List<Listing> listings = [];
  var listingImages = [];
  final List<Widget> images = [];
  List projects = [];
  Widget? quickLinks;

  var data = [].obs;

  TextEditingController locationController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController aiSearchController = TextEditingController();

  @override
  void onInit() async {
    try {
      if (settings!.banners != null) {
        for (int i = 0; i < settings!.banners!.length; i++) {
          var img = CachedNetworkImageProvider(
           await CloudStorage().getFileDirect(docRef: settings!.banners![i]),
          );
          await precacheImage(img, Get.context!);
          images.add(Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: img
              )
            ),
          ));
        }
      }
      quickLinks = await QuickLinksModel().initialize();
      await getNews();
      await getImages();
      await getListings();
      await getProjects();
      //await Future.delayed(Duration(seconds: 1,milliseconds: 500));
      homeState.value = HomeState.loaded;
    } catch (e,ex) {
      print(ex);
      homeState.value = HomeState.error;
    }
    super.onInit();
  }

  getProjects()async{
    if (settings!.featuredProjects != null) {
      for (int i = 0; i < settings!.featuredProjects!.length; i++) {
        projects.add(await Project.getById(settings!.featuredProjects![i]));
      }
    }
  }

  getNews() async {
    if (settings!.featuredNews!.isNotEmpty) {
      for (int i = 0; i < settings!.featuredNews!.length; i++) {
        if(settings!.featuredNews![i] != ''){

          news.add(await News(id: settings!.featuredNews![i]).getNews());
        }
      }
    }
  }

  getListings() async {
    if (settings!.featuredListings!.isNotEmpty) {
      for (int i = 0; i < settings!.featuredListings!.length; i++) {
        settings!.featuredListings![i] != ''
            ? listings
                .add(await Listing().getListing(settings!.featuredListings![i]))
            : null;
      }
    }
  }

  getImages() async {
    listingImages.add(PropertiesModels(
        image: settings!.preSellingPicture
            .toString()
            .notEmpty(AppStrings.noImageWhite),
        label: 'PRE-SELLING'));
    listingImages.add(PropertiesModels(
        image: settings!.residentialPicture
            .toString()
            .notEmpty(AppStrings.noImageWhite),
        label: 'RESIDENTIAL'));
    listingImages.add(PropertiesModels(
        image: settings!.commercialPicture
            .toString()
            .notEmpty(AppStrings.noImageWhite),
        label: 'COMMERCIAL'));
    listingImages.add(PropertiesModels(
        image: settings!.rentalPicture
            .toString()
            .notEmpty(AppStrings.noImageWhite),
        label: 'RENTAL'));
    listingImages.add(PropertiesModels(
        image: settings!.auctionPicture
            .toString()
            .notEmpty(AppStrings.noImageWhite),
        label: 'AUCTION'));
  }

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

  search() async {}

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
