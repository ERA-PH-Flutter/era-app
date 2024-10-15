import 'package:get/get.dart';

import '../../../../../app/services/firebase_database.dart';
import '../../../../../app/services/local_storage.dart';
import '../../../../../repository/listing.dart';

enum SoldState{
  loading,
  loaded,
  error,
  empty
}
class SoldPropertiesController extends GetxController{
  var store = Get.find<LocalStorageService>();
  var soldState = SoldState.loading.obs;
  var soldListings = [].obs;
  @override
  void onInit()async{
    List<Listing> listings = await Database().searchListingsByUserId(Get.arguments);
    for (var listing in listings) {
      if(listing.isSold ?? false){
        soldListings.add(listing);
      }
    }
    if(soldListings.isEmpty){
      soldState.value = SoldState.empty;
    }else{
      soldState.value = SoldState.loaded;
    }
    super.onInit();
  }
}