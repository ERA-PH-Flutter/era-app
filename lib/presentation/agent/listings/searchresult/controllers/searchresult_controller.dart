import 'package:eraphilippines/app/widgets/quick_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../app/services/local_storage.dart';
import '../../../../../repository/listing.dart';
import '../../../../global.dart';

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
  var aiSearchControllers = TextEditingController();
  var data = [].obs;
  var searchQuery = ''.obs;
  var expanded = false.obs;
  var quickLinks = Column().obs;

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
  void onInit() async {
    searchResultState.value = SearchResultState.loading;
    quickLinks.value = await QuickLinksModel().initialize();
    data.clear();
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
      print(e);
      print(ex);
      searchResultState.value = SearchResultState.error;
    }
    super.onInit();
  }

  @override
  void onClose() {
    //arguments = null;
    Get.delete<SearchResultController>(force: true);
    super.onClose();
  }

  loadData(loadedData) {
    loadedData = loadedData ?? [];
    print(loadedData);
    loadedData.forEach((d) {
      if(d != null){
        if (!(d['is_sold'] ?? false)) {
          data.add(d);
        }
      }
    });
    //data.assignAll(loadedData);
    if (data.isEmpty) {
      searchResultState.value = SearchResultState.empty;
    } else {
      searchResultState.value = SearchResultState.loaded;
    }
  }
}
