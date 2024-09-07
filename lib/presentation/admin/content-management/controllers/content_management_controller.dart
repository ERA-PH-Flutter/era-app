import 'dart:io';

import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../app/services/local_storage.dart';

class ContentManagementController extends GetxController with BaseController {
  var store = Get.find<LocalStorageService>();
  RxList images = [].obs;
  final picker = ImagePicker();
  var listings = [].obs;

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
}
