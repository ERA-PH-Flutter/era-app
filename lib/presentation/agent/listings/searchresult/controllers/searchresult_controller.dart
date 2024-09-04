import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../app/services/local_storage.dart';

enum SearchResultState {
  loading,
  loaded,
  error,
  empty,
  searching,
}

class SearchResultController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var searchResultState = SearchResultState.loading.obs;
  var aiSearchController = TextEditingController();
  var data = [].obs;
  var searchQuery = ''.obs;
  var expanded = false.obs;

  TextEditingController locationController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var isForSale = 0.obs;
  var isForLease = true.obs;

  var showFullSearch = false.obs;
  var showQuickSearch = false.obs;
  var showAdvancedSearch = true.obs;
  var focusNode = FocusNode();

  var selectedPropertyTypeSearch = RxnString();
  var selectedLocationSearch = RxnString();
  var selectedPriceSearch = RxnString();

  var propertyTypeSearch = [
    "Pre-selling",
    "Residential",
    "Commercial",
    "Rental",
    "Auction",
  ];

  var priceSearch = [
    " 1,000 -  100,000",
    " 100,000 - 500,000",
    " 100,000 - 1M",
    " 1M - 5M",
    " 10M - 50M",
    " 50M - 100M",
    " 100>",
  ];

  @override
  void onInit() {
    data.clear();
    searchResultState.value = SearchResultState.loading;
    try {
      if (Get.arguments == null || Get.arguments.isEmpty) {
        //searchResultState.value = SearchResultState.searching;
        if (settings!.featuredListings!.isNotEmpty) {
          var listingsJson = settings!.featuredListings!.map((listing) async {
            return await Listing().getListing(listing).toMap();
          }).toList() as List<Map<String, dynamic>>;
          loadData(listingsJson);
        } else {
          loadData([]);
        }
      } else {
        loadData(Get.arguments[0]);
        searchQuery.value = Get.arguments[1];
      }
    } catch (e, ex) {
      print(ex);
      searchResultState.value = SearchResultState.error;
    }
    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<SearchResultController>(force: true);
    super.onClose();
  }

  loadData(List<Map<String, dynamic>> loadedData) {
    data.value = loadedData.map((d) {
      if (!d['is_sold']) {
        return d;
      }
    }).toList();
    //data.assignAll(loadedData);
    if (data.isEmpty) {
      searchResultState.value = SearchResultState.empty;
    } else {
      searchResultState.value = SearchResultState.loaded;
    }
  }
}
