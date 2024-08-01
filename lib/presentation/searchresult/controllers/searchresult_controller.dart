import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';

enum SearchResultState{
  loading,
  loaded,
  error,
  empty,
  searching,
}
class SearchResultController extends GetxController{
  var store = Get.find<LocalStorageService>();
  var searchResultState = SearchResultState.loading.obs;
  var data;
  var search;
  @override
  void onInit() {
    try{
      if(Get.arguments.isEmpty){
        searchResultState.value = SearchResultState.searching;
      }else{
        data = Get.arguments[0];
        search = Get.arguments[1];
        if(data.isEmpty){
          searchResultState.value = SearchResultState.empty;
        }
        searchResultState.value = SearchResultState.loaded;
      }
    }catch(e){
      print(e);
      searchResultState.value = SearchResultState.error;
    }

    print(searchResultState.value);
    super.onInit();
  }
}