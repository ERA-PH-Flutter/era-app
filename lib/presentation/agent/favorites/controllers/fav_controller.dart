import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum FavState{
  loading,
  loaded,
  error,
  empty
}
class FavController extends GetxController{
  var store = Get.find<LocalStorageService>();
  var favState = FavState.loading.obs;
  @override
  void onInit() {
    favState.value = FavState.loaded;
    super.onInit();
  }

   var favoritesList = <RealEstateListing>[].obs; // Observable list of favorites

  void addToFavorites(RealEstateListing listing) {
    if (!favoritesList.contains(listing)) {
      favoritesList.add(listing);
    }
  }

  void removeFromFavorites(RealEstateListing listing) {
    favoritesList.remove(listing);
  }

  bool isFavorite(RealEstateListing listing) {
    return favoritesList.contains(listing);
  }
}
 