import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum FavState { loading, loaded, error, empty }

class FavController extends GetxController {
  var favoritesList = <RealEstateListing>[].obs;

  var store = Get.find<LocalStorageService>();
  var favState = FavState.loading.obs;

  List<String> sorting = ['Category', 'Date Added', 'Price', 'Location'];
  @override
  void onInit() {
    favState.value = FavState.loaded;
    super.onInit();
  }

  void addToFavorites(RealEstateListing listing) {
    if (!favoritesList.contains(listing)) {
      favoritesList.add(listing);
    }
  }

  void removeFromFavorites(RealEstateListing listing) {
    favoritesList.remove(listing);
  }

  void removeSelectedFavorites() {
    for (int index in selectedItems) {
      removeFromFavorites(favoritesList[index]);
    }
    clearSelection();
  }

  bool isFavorite(RealEstateListing listing) {
    return favoritesList.contains(listing);
  }

  var selectedItems = <int>[].obs;
  var selectionModeActive = false.obs;

  void toggleSelection(int index) {
    if (selectedItems.contains(index)) {
      selectedItems.remove(index);
    } else {
      selectedItems.add(index);
    }

    if (selectedItems.isEmpty) {
      exitSelectionMode();
    } else {
      selectionModeActive.value = true;
    }
  }

  bool isSelected(int index) {
    return selectedItems.contains(index);
  }

  void clearSelection() {
    selectedItems.clear();
    selectionModeActive.value = false;
  }

  void enterSelectionMode() {
    selectionModeActive.value = true;
  }

  void exitSelectionMode() {
    clearSelection();
  }

  bool get anyItemSelected => selectedItems.isNotEmpty;
}
