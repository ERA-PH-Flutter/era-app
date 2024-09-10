import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../repository/listing.dart';
import '../../../../global.dart';

enum FavState { loading, loaded, error, empty , preview}

class FavController extends GetxController with BaseController {
  var favoritesList = [].obs;
  List<ScreenshotController> screenshotControllers = [];
  var selectedItems = <int>[].obs;
  var selectedCount = 0.obs;
  var selectedListings = [].obs;
  var selectionModeActive = false.obs;
  var favState = FavState.loading.obs;
  var sortBy = 'date'.obs;
  var sortOrder = 'asc'.obs;
  var listing = [];

  @override
  void onInit() async {
    if(user != null){
      if (user!.favorites!.isNotEmpty) {
        for (int i = 0; i < user!.favorites!.length; i++) {
          Listing listingA = await Listing().getListing(user!.favorites![i]);
          if(!(listingA.isSold ?? true)){
            favoritesList.add(listingA);
          }
        }
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
      selectedCount.value--;
      selectedItems.remove(index);
    } else {
      selectedCount.value++;
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
