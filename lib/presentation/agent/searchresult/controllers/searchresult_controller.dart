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
  var search;

  @override
  void onInit() {
    super.onInit();
    try {
      if (Get.arguments == null || Get.arguments.isEmpty) {
        searchResultState.value = SearchResultState.searching;
      } else {
        loadData( Get.arguments[0]);
      }
    } catch (e) {
      searchResultState.value = SearchResultState.error;
    }
    print(searchResultState.value);
  }
  loadData(loadedData){
    data.value = loadedData;
    search = loadedData;
    print(search);
    if (data.isEmpty) {
      searchResultState.value = SearchResultState.empty;
    } else {
      searchResultState.value = SearchResultState.loaded;
    }
  }
}

 
 