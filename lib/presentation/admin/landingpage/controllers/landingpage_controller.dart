import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

enum LandingState { loading, loaded, error, empty }

enum AdminSection {
  agentProfile,
  addAgent,
  approvedAgents,
  roster,
  addProject,
  propertyList,
  propertyInfo,
  addProperty,
  editProperty,
  homepage,
  aboutUs,
}

class LandingPageController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var landingState = LandingState.loading.obs;
  var selectedSection = AdminSection.homepage.obs;

  @override
  void onInit() {
    landingState.value = LandingState.loaded;
    super.onInit();
  }

  void onSectionSelected(AdminSection section) {
    selectedSection.value = section;
  }
}
