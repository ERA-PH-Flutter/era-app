import 'package:eraphilippines/app/models/ai_filters.dart';
import 'package:eraphilippines/app/services/ai_search.dart';
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
  var aiSearchController = TextEditingController();
  var aiSearchAgentsController = TextEditingController();

  RxList<Listing> data = <Listing>[].obs;
  var searchQuery = ''.obs;
  RxInt count = 10.obs;
  int pageSize = 0;
  var expanded = false.obs;
  var quickLinks = Column().obs;
  ScrollController scrollController = ScrollController();
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
    initListing();
    super.onInit();
  }

  Future<void> initListing() async {
    pageSize = count.value;

    searchResultState.value = SearchResultState.loading;
    quickLinks.value = await QuickLinksModel().initialize();
    data.clear();
    try {
      if (Get.arguments == null || Get.arguments.isEmpty) {
        var tempData = [];
        for (int i = 0; i < settings!.featuredListings!; i++) {
          tempData.add(
              (await Listing().getListing(settings!.featuredListings!)).toMap());
        }
        loadData(tempData.map((e) => Listing.fromJSON(e)).toList());
      } else {
        loadData(Get.arguments[0].map((e) => Listing.fromJSON));
        searchQuery.value = Get.arguments[1];
      }
    } catch (e) {
      searchResultState.value = SearchResultState.error;
    }
  }

  Future loadData(List<Listing> loadedData) async {
    loadedData = loadedData;
    for (var d in loadedData) {
      if (!(d.isSold ?? false)) {
        data.add(d);
      }
    }
    //data.assignAll(loadedData);
    if (data.isEmpty) {
      searchResultState.value = SearchResultState.empty;
    } else {
      searchResultState.value = SearchResultState.loaded;
    }
  }

  Future searchListingType(String type) async {
    searchResultState.value = SearchResultState.loading;
    List<Listing> listings = await AI(query: type).listingSearch();
    data.value = listings;
    searchQuery.value = type.toString();
    searchResultState.value =
        listings.isEmpty ? SearchResultState.empty : SearchResultState.loaded;
  }

  Future searchListingQuery(
      {required String query,
      List<AiFilters> overrideAiFilters = const []}) async {
    searchResultState.value = SearchResultState.loading;
    print('gemini search overrideAiFilters 1 $overrideAiFilters');

    List<Listing> listings = await AI(query: query)
        .listingSearch(overrideAiFilters: overrideAiFilters);
    data.value = listings;
    searchQuery.value = query.toString();
    searchResultState.value =
        listings.isEmpty ? SearchResultState.empty : SearchResultState.loaded;
  }
}
