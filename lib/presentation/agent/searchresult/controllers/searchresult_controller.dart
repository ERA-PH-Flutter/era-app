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

  var showFullSearch= false.obs;
  var showQuickSearch= false.obs;

  var focusNode = FocusNode();  


  @override
  void onInit() {
    super.onInit();
    data.clear();
    searchResultState.value = SearchResultState.loading;
    try {
      if (Get.arguments == null || Get.arguments.isEmpty) {
        searchResultState.value = SearchResultState.loaded;
      } else {
        loadData(Get.arguments[0]);
        searchQuery.value = Get.arguments[1];
      }
    } catch (e, ex) {
      print(ex);
      searchResultState.value = SearchResultState.error;
    }
  }

  @override
  void onClose() {
    Get.delete<SearchResultController>();
    super.onClose();
  }

  loadData(loadedData) {
    data.value = loadedData;
    if (data.isEmpty) {
      searchResultState.value = SearchResultState.empty;
    } else {
      searchResultState.value = SearchResultState.loaded;
    }
  }
}
