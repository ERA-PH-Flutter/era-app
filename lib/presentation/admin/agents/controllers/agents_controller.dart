import 'dart:io';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/services/local_storage.dart';

enum AgentAdminState {
  loading,
  loaded,
  error,
  empty,
}

class AgentAdminController extends GetxController with BaseController {
  var store = Get.find<LocalStorageService>();

  var agentState = AgentAdminState.loading.obs;
  @override
  void onInit() {
    agentState.value = AgentAdminState.loaded;
    super.onInit();
  }

  List<Listing> listings = [];

  RxList images = [].obs;
  final picker = ImagePicker();
  final removeImage = false.obs;

  var agentType = ['ASC', 'AMM', 'MM', 'SMM', 'MD', 'SMD', 'ADD', 'BDD'];
  var selectedAgentType = RxnString();

  TextEditingController fNameA = TextEditingController();
  TextEditingController lNameA = TextEditingController();
  TextEditingController emailAdressA = TextEditingController();
  TextEditingController dateBirthA = TextEditingController();
  TextEditingController sexA = TextEditingController();
  TextEditingController locationA = TextEditingController();
  TextEditingController licenseNA = TextEditingController();
  TextEditingController phoneNA = TextEditingController();
  TextEditingController passwordA = TextEditingController();
  TextEditingController confirmPA = TextEditingController();
  TextEditingController positionA = TextEditingController();
  TextEditingController descriptionA = TextEditingController();
  TextEditingController officeLA = TextEditingController();
  TextEditingController licensedNumA = TextEditingController();
  TextEditingController parking = TextEditingController();

//create listing controller

  // TextEditingController officeLA = TextEditingController();

  Future getImageGallery() async {
    try {
      final imagePick = await picker.pickMultiImage();
      if (imagePick.isNotEmpty) {
        for (var image in imagePick) {
          images.add(File(image.path));
        }
      }
    } on PlatformException catch (e) {
      return e;
    }
  }

  removeAt(int index) {
    images.removeAt(index);

    if (images.isEmpty) {
      print("itsfine");
    }
  }

  removeMode() {
    removeImage.value = !removeImage.value;
  }

  clearImage() {
    images.clear();
  }
}
