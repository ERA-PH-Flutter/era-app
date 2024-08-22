import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/listing.dart';

enum AgentListingsState{
  loading,
  loaded,
  error,
}
class AgentListingsController extends GetxController{
  var store = Get.find<LocalStorageService>();
  var agentListingsState = AgentListingsState.loading.obs;
  var user;
  List<Listing> listings = [];
  @override
  void onInit()async{
    user = await EraUser().getById(Get.arguments[0]);
    listings = (await Database().searchListingsByUserId(Get.arguments[0]));
    agentListingsState.value = AgentListingsState.loaded;
    super.onInit();
  }
  /*
  filter(category)async{
    if(category == "favorites"){
      listings.map((listing){
        if(user!.favorites.contains(listing.id)){
          return listing;
        }
      });
    }else if(category == "sold"){
      listings.map((listing){
        if(listing.isSold ?? false){
          return listing;
        }
      });
    }else if(category == "archive"){
      listings.map((listing){
        if(user!.archives.contains(listing.id)){
          return listing;
        }
      });
    }
  }
  */
}