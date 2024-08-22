import 'package:get/get.dart';
import '../../../../app/services/firebase_database.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/listing.dart';
import '../../../global.dart';

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
    listings.forEach((listing){
      if(listing.isSold ?? false){
        soldListings.add(listing);
      }
    });
    print("sold: " + listings.toString());
    if(soldListings.isEmpty){
      soldState.value = SoldState.empty;
    }else{
      soldState.value = SoldState.loaded;
    }
    super.onInit();
  }
}