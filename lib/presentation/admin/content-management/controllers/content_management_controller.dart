import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/models/propertieslisting.dart';
import 'package:eraphilippines/app/models/settings.dart' as era_settings;
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
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
  var changeCategoryIcon = [].obs;

  final List<String> bannersImages = [];
  var listingImages = [];
  @override
  void onInit() async {
    try {
      if (settings != null) {
        if (settings!.banners != null) {
          for (int i = 0; i < settings!.banners!.length; i++) {
            bannersImages.add(settings!.banners![i]);
            images.add(await CloudStorage()
                .getFileBytes(docRef: settings!.banners![i]));
          }
        }
      } else {
        settings = era_settings.Settings.fromJSON((await FirebaseFirestore
                .instance
                .collection('settings')
                .doc('main')
                .get())
            .data()!);
        for (int i = 0; i < settings!.banners!.length; i++) {
          images.add(
              await CloudStorage().getFileBytes(docRef: settings!.banners![i]));
        }
      }
      //await getImages();
      print(images);
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

  Future pickImageFromWeb() async {
    try {
      final imagePick = await picker.pickMultiImage();
      if (imagePick.isNotEmpty) {
        for (var image in imagePick) {
          images.add(await image.readAsBytes());
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

  var categoryIcons = [
    AppEraAssets.agricultural,
    AppEraAssets.apartment,
    AppEraAssets.commercial,
    AppEraAssets.condo,
    AppEraAssets.factory,
    AppEraAssets.farm,
    AppEraAssets.hotel,
    //AppEraAssets.housenlot,
    AppEraAssets.house1,
    AppEraAssets.lot,
    AppEraAssets.industrial,
    AppEraAssets.office,
    AppEraAssets.parkingLot,
    // AppEraAssets.residential,
    //AppEraAssets.townhouse,
    AppEraAssets.resort,
    // AppEraAssets.warehouse,
    // AppEraAssets.penthouse,
    AppEraAssets.beachHouse,
    //  AppEraAssets.loft,
    AppEraAssets.school,
    //  AppEraAssets.room,
//AppEraAssets.memorial,
    // AppEraAssets.coworking,
    // AppEraAssets.studio,
  ];
}
