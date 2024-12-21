import 'package:eraphilippines/app/widgets/quick_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../app/services/local_storage.dart';
import '../../../../../repository/listing.dart';
import '../../../../app/models/ai_filters.dart';
import '../../../../app/services/ai_search.dart';
import '../../../global.dart';

enum ListingsWebState {
  loading,
  loaded,
  error,
  empty,
  searching,
}

class ListingsWebController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var listingsWebState = ListingsWebState.loading.obs;
  var aiSearchController = TextEditingController();
  var data = [].obs;
  var searchQuery = ''.obs;
  var expanded = false.obs;
  Widget? quickLinks;
  var images = [].obs;
  var isFav = false.obs;
  var currentImage = ''.obs;

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

  @override
  void onInit() async {
    data.clear();
    listingsWebState.value = ListingsWebState.loading;
    quickLinks = await QuickLinksModel().initialize();
    try {
      if (Get.arguments == null || Get.arguments.isEmpty && data.isEmpty) {
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
      listingsWebState.value = ListingsWebState.error;
    }
    super.onInit();
  }

  @override
  void onClose() {
    //arguments = null;
    Get.delete<ListingsWebController>(force: true);
    super.onClose();
  }

  loadData(loadedData) {
    listingsWebState.value = ListingsWebState.loading;
    data.clear();
    loadedData = loadedData ?? [];
    loadedData.forEach((d) {
      if (d != null) {
        if (!(d['is_sold'] ?? false)) {
          data.add(d);
        }
      }
    });
    //data.assignAll(loadedData);

    if (data.isEmpty) {
      print("data : ${data.isEmpty}");
      listingsWebState.value = ListingsWebState.empty;
    } else {
      listingsWebState.value = ListingsWebState.loaded;
    }
    update();
  }
  Future searchListingQuery(
      {required String query,
        List<AiFilters> overrideAiFilters = const []}) async {
    listingsWebState.value = ListingsWebState.loading;
    print('gemini search overrideAiFilters 1 $overrideAiFilters');

    List<Listing> listings = await AI(query: query)
        .listingSearch(overrideAiFilters: overrideAiFilters);
    listings.forEach((listing){
      if(listing.runtimeType == Listing){
        data.add(listing);
      }
    });
    searchQuery.value = query.toString();
    listingsWebState.value =
    listings.isEmpty ? ListingsWebState.empty : ListingsWebState.loaded;
  }
}
