import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

enum ListingState {
  loading,
  loaded,
  empty,

  searching,
  error,
}

class ListingController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var listingState = ListingState.loading.obs;

  RxString price = "".obs;
  var symbol = "PHP ";
  var selectedLocation = ''.obs;
  var selectedPropertyType = ''.obs;
  var selectedPriceRange = ''.obs;
  var isForSale = 0.obs;
  var isForLease = true.obs;
  var isClicked = false.obs;
  var currentPage = 0.obs;
  var searchQuery = ''.obs;
  var data = [].obs;
  var showFullSearch = false.obs;
  List<Listing> listings = [];

  TextEditingController locationController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController aiSearchController = TextEditingController();

  @override
  void onInit() async {
    data.clear();
    listingState.value = ListingState.loading;
    try {
      if (Get.arguments == null || Get.arguments.isEmpty) {
        var tempData = [];
        for (int i = 0; i < settings!.featuredListings!.length; i++) {
          tempData.add(
              (await Listing().getListing(settings!.featuredListings![i]))
                  .toMap());
        }
        loadData(tempData);
      } else {
        loadData(Get.arguments[0]);
        searchQuery.value = Get.arguments[1];
      }
    } catch (e, ex) {
      print(ex);
      listingState.value = ListingState.error;
    }
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

  @override
  void onClose() {
    //arguments = null;
    Get.delete<ListingController>(force: true);
    super.onClose();
  }

  loadData(loadedData) {
    data.value = loadedData.map((d) {
      if (!d['is_sold']) {
        return d;
      }
    }).toList();
    //data.assignAll(loadedData);
    if (data.isEmpty) {
      listingState.value = ListingState.empty;
    } else {
      listingState.value = ListingState.loaded;
    }
  }
}
