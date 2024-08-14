import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum AgentsAState { loading, loaded, error, empty }

class AgentsAdminController extends GetxController with BaseController {
  var store = Get.find<LocalStorageService>();
  var agentAState = AgentsAState.loading.obs;
  @override
  void onInit() {
    agentAState.value = AgentsAState.loaded;
    super.onInit();
  }
  TextEditingController propertyNameControllerA = TextEditingController();

}
