import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

enum WebLandingState { loading, loaded, error, empty }

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

class WebLandingPageController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var weblandingState = WebLandingState.loading.obs;

  @override
  void onInit() {
    weblandingState.value = WebLandingState.loaded;
    super.onInit();
  }

  var controller = OverlayPortalController();

  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
  }
}
