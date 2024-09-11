import 'dart:io';

import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../app/services/local_storage.dart';

class ContentManagementController extends GetxController with BaseController {
  var store = Get.find<LocalStorageService>();
  RxList images = [].obs;
  final picker = ImagePicker();
  var listings = [].obs;

  TextEditingController titleController = TextEditingController();
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

  var selectionModeActive = false.obs;
  var selectedItems = <int>[].obs;

  void toggleSelection(int index) {
    if (selectedItems.contains(index)) {
      selectedItems.remove(index);
    } else {
      selectedItems.add(index);
    }
    selectionModeActive.value = selectedItems.isNotEmpty;
  }

  bool isSelected(int index) {
    return selectedItems.contains(index);
  }
}
