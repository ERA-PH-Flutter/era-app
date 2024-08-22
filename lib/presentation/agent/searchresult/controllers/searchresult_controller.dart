import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

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

  TextEditingController locationController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var isForSale = 0.obs;
  var isForLease = true.obs;

  @override
  void onInit() {
    super.onInit();
    data.clear();
    print(Get.arguments[0].runtimeType);
    searchResultState.value = SearchResultState.loading;
    try {
      if (Get.arguments == null || Get.arguments.isEmpty) {
        searchResultState.value = SearchResultState.searching;
      } else {
        loadData( Get.arguments[0]);
        searchQuery.value = Get.arguments[1];
      }

    } catch (e,ex) {
      searchResultState.value = SearchResultState.error;
    }
    print(Get.arguments[0]);
  }

  @override
  void onClose() {
    Get.delete<SearchResultController>();
    super.onClose();
  }

  loadData(loadedData){
    data.value = loadedData;
    if (data.isEmpty) {
      searchResultState.value = SearchResultState.empty;
    } else {
      searchResultState.value = SearchResultState.loaded;
    }
  }
}

 
 