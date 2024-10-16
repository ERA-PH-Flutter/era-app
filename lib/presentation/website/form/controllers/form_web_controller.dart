import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

// enum BuyWebState { loading, loaded, error, empty }

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

class FormWebController extends GetxController {
  var store = Get.find<LocalStorageService>();
  //var buylandingState = BuyWebState.loading.obs;

  var isCheckedYes = false.obs;
  var isCheckedNotNow = false.obs;

  TextEditingController name = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController emailAd = TextEditingController();
  TextEditingController message = TextEditingController();

  // @override
  // void onInit() {
  //   buylandingState.value = BuyWebState.loaded;
  //   super.onInit();
  // }
}
