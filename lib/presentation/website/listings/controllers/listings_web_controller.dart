import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

enum ListingsWebState { loading, loaded, error, empty }

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

class ListingsWebController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var buylandingState = ListingsWebState.loading.obs;

  @override
  void onInit() {
    buylandingState.value = ListingsWebState.loaded;
    super.onInit();
  }
}
