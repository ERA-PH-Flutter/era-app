import 'package:eraphilippines/app/services/local_storage.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AHomeState { loading, loaded, error, empty }

class HomeAController extends GetxController with BaseController {
  var store = Get.find<LocalStorageService>();
  var ahomeState = AHomeState.loading.obs;
  @override
  void onInit() {
    ahomeState.value = AHomeState.loaded;
    super.onInit();
  }

  TextEditingController propertyNameController = TextEditingController();
}
