import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

enum LandingState { loading, loaded, error, empty }

// enum AdminSection {
//   agentProfile,
//   addAgent,
//   approvedAgents,
//   roster,
//   addProject,
//   propertyList,
//   propertyInfo,
//   addProperty,
// //    editProperty,
//   homepage,
//   aboutUs,
// }

class LandingPageController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var landingState = LandingState.loading.obs;
  var arguments = [];
  // var selectedSection = AdminSection.homepage.obs;
  var selectedSectionIndex = 13.obs;

  var selectedTile = -1;
  List<ExpansionTileController> expandedControllers = [
    ExpansionTileController(),
    ExpansionTileController(),
    ExpansionTileController(),
    ExpansionTileController(),
    ExpansionTileController(),
    ExpansionTileController(),
    ExpansionTileController(),
  ];
  @override
  void onInit() {
    landingState.value = LandingState.loaded;
    super.onInit();
  }

  void onSectionSelected(int index) {
    selectedSectionIndex.value = index;
  }
}
