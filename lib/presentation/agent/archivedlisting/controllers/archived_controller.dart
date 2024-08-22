import 'package:get/get.dart';

import '../../../../repository/listing.dart';
import '../../../global.dart';

enum ArchiveState {loading,loaded,empty,error}

class ArchivedController extends GetxController {
  var selectedItems = <int>[].obs;
  var selectionModeActive = false.obs;
  var archiveListings = [].obs;
  var archiveState = ArchiveState.loading.obs;
  @override
  void onInit()async{
    if(user!.favorites!.isNotEmpty){
      for(int i = 0;i<user!.archives!.length;i++){
        archiveListings.add( await Listing().getListing(user!.archives![i]));
      }
    }
    print(archiveListings);
    if(archiveListings.isEmpty){
      archiveState.value = ArchiveState.empty;
    }else{
      archiveState.value = ArchiveState.loaded;
    }
    super.onInit();
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
    selectionModeActive.value = false;
    clearSelection();
  }

  bool get anyItemSelected => selectedItems.isNotEmpty;
}
