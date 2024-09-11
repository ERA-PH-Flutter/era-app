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
  var selectedSectionIndex = 0.obs;
  @override
  void onInit() {
    landingState.value = LandingState.loaded;
    super.onInit();
  }

  void onSectionSelected(int index) {
    selectedSectionIndex.value = index;
  }
}
