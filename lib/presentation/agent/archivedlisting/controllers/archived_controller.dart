import 'package:get/get.dart';

class ArchivedController extends GetxController {
  var selectedItems = <int>[].obs;
  var selectionModeActive = false.obs;

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
    selectionModeActive.value = false;
    clearSelection();
  }

  bool get anyItemSelected => selectedItems.isNotEmpty;
}
