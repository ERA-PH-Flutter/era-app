import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum ListingState {
  loading,
  loaded,
  error,
}

class ListingController extends GetxController {
  var store = Get.find<LocalStorageService>();

  var selectedLocation = ''.obs;
  var selectedPropertyType = ''.obs;
  var selectedPriceRange = ''.obs;
  var isForSale = 0.obs;
  var isForLease = true.obs;
  var isClicked = false.obs;
  var currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (images.isNotEmpty) {
      currentImage.value = images[0];
    }
  }

  final int totalPages = 10;

  void onPageSelected(int index) {
    currentPage.value = index;
  }

  var currentImage = ''.obs;

  void onSelectedImage(String newImage) {
    currentImage.value = newImage;
  }

  List<String> images = [
    'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/carousel-slider%2Fcarouselslider1.png?alt=media&token=3a2e0824-4296-4c8b-b6a5-ee7581df3a88',
    'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/carousel-slider%2Fcarouselsliderpic2.jpg?alt=media&token=c1d41db0-8207-4c92-9110-38dd7e164d32',
    'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/carousel-slider%2Fcarouselsliderpic3.jpg?alt=media&token=17bbd031-9f8d-41f4-8949-220b3565635b',
    'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/carousel-slider%2Fcarouselsliderpic4.jpg?alt=media&token=4c4dbb85-6e1a-45ff-aa37-692c253bb162',
    'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/carousel-slider%2Fcarouselsliderpic5.jpg?alt=media&token=063b4185-ed1e-4508-92b5-8999c2d2a8be',
  ];
}
