import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/services/local_storage.dart';

enum AddListingsState {
  loading,
  loaded,
  error,
}

class AddListingsController extends GetxController {
  var store = Get.find<LocalStorageService>();
  RxList images = [].obs;
  final picker = ImagePicker();
  var passwordVisible = false.obs;
  var confirmPasswordVisible = false.obs;
  var email = TextEditingController();
  var password = TextEditingController();

  TextEditingController propertyNameController = TextEditingController();
  TextEditingController propertyCostController = TextEditingController();
  TextEditingController pricePerSqmController = TextEditingController();
  TextEditingController floorAreaController = TextEditingController();
  TextEditingController bedsController = TextEditingController();
  TextEditingController bathsController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController offerTypeController = TextEditingController();
  TextEditingController viewController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController propertyTypeController = TextEditingController();
  TextEditingController propertySubCategoryController = TextEditingController();

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

  // clearImage() {
  //   images.clear();
  // }
}
