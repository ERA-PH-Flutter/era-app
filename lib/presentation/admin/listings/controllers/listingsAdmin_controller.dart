import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum ListingsAState { loading, loaded, error, empty }

class ListingsAdminController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var listingState = ListingsAState.loading.obs;
  @override
  void onInit() {
    listingState.value = ListingsAState.loaded;
    super.onInit();
  }

  TextEditingController propertyName_A = TextEditingController();
}
