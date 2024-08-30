import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/listing.dart';
import '../../../global.dart';

enum FavState { loading, loaded, error, empty }

class FavController extends GetxController {
  var favoritesList = [].obs;

  var selectedItems = <int>[].obs;
  var selectionModeActive = false.obs;
  var favState = FavState.loading.obs;
  var listing = [];

  @override
  void onInit() async {
    if (user!.favorites!.isNotEmpty) {
      for (int i = 0; i < user!.favorites!.length; i++) {
        favoritesList.add(await Listing().getListing(user!.favorites![i]));
      }
    }
    if (favoritesList.isEmpty) {
      favState.value = FavState.empty;
    } else {
      favState.value = FavState.loaded;
    }
    super.onInit();
  }

  void onGeneratePdfButtonPressed() {
    if (!selectionModeActive.value) {
      enterSelectionMode();
    } else {}
  }

  void toggleSelection(int index) {
    if (selectedItems.contains(index)) {
      selectedItems.remove(index);
    } else {
      selectedItems.add(index);
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
}
