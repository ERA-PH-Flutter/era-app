import 'dart:io';

import 'package:eraphilippines/app/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum AddEditListingsState { loading, loaded, error, empty }

class AddEditListingsController extends GetxController {
  var store = Get.find<LocalStorageService>();

  RxList images = [].obs;
  final picker = ImagePicker();

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
  TextEditingController descriptionController = TextEditingController();
  TextEditingController parkingController = TextEditingController();
}
