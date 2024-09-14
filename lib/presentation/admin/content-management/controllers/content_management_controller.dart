import 'dart:io';

import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/models/propertieslisting.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../app/services/local_storage.dart';

enum HomepageState {
  loading,
  loaded,
  error,
}

class ContentManagementController extends GetxController with BaseController {
  var store = Get.find<LocalStorageService>();
  var homepageState = HomepageState.loading.obs;
  RxList images = [].obs;
  final picker = ImagePicker();
  var listings = [].obs;

  final List<String> bannersImages = [];
  var listingImages = [];
  @override
  void onInit() async {
    try {
      if (settings != null) {
        if (settings!.banners != null) {
          for (int i = 0; i < settings!.banners!.length; i++) {
            bannersImages.add(settings!.banners![i]);
          }
        }
      }
      //await getImages();
      homepageState.value = HomepageState.loaded;
    } catch (e) {
      print(e);
      homepageState.value = HomepageState.error;
    }
    super.onInit();
  }

  getImages() async {
    listingImages.add(PropertiesModels(
        image: settings!.preSellingPicture
            .toString()
            .notEmpty(AppStrings.noImageWhite),
        label: 'PRE-SELLING'));
    listingImages.add(PropertiesModels(
        image: settings!.residentialPicture
            .toString()
            .notEmpty(AppStrings.noImageWhite),
        label: 'RESIDENTIAL'));
    listingImages.add(PropertiesModels(
        image: settings!.commercialPicture
            .toString()
            .notEmpty(AppStrings.noImageWhite),
        label: 'COMMERCIAL'));
    listingImages.add(PropertiesModels(
        image: settings!.rentalPicture
            .toString()
            .notEmpty(AppStrings.noImageWhite),
        label: 'RENTAL'));
    listingImages.add(PropertiesModels(
        image: settings!.auctionPicture
            .toString()
            .notEmpty(AppStrings.noImageWhite),
        label: 'AUCTION'));
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController description = TextEditingController();

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
