import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

enum ListingState {
  loading,
  loaded,
  error,
}

class ListingController extends GetxController {
  var store = Get.find<LocalStorageService>();
  RxString price = "".obs;
  var symbol = "PHP ";
  var selectedLocation = ''.obs;
  var selectedPropertyType = ''.obs;
  var selectedPriceRange = ''.obs;
  var isForSale = 0.obs;
  var isForLease = true.obs;
  var isClicked = false.obs;
  var currentPage = 0.obs;

  TextEditingController locationController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController aiSearchController = TextEditingController();

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

  var images = [];
  var isFav = false.obs;
}