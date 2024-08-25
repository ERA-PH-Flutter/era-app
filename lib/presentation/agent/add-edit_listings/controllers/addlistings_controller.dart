import 'dart:io';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/services/local_storage.dart';

enum AddListingsState {
  loading,
  loaded,
  error,
}

class AddListingsController extends GetxController with BaseController {
  var store = Get.find<LocalStorageService>();
  RxList images = [].obs;
  final picker = ImagePicker();
  final removeImage = false.obs;
  var selectedPropertyT = RxnString();
  var selectedOfferT = RxnString();
  var selectedPropertySubCategory = RxnString();
  var selectedView = RxnString();
  
  var viewL = [
    "Sunset View",
    "City View",
    "Mountain View",
    "Sea View",
    "Lake View",
    "River View",
    "Garden View",
    "Others"
  ];

  var subCategory = [
    "Apartment",
    "House",
    "Lot",
    "Office",
    "Retail",
    "Warehouse",
    "Commercial",
    "Residential",
    "Condominium",
    "Townhouse",
    "Others",
  ];
  var propertyT = [
    "House and Lot",
    "Condominium",
    "Townhouse",
    "Commercial",
    "Industrial",
    "Agricultural",
    "Land",
    "Foreclosed",
    "Pre-selling",
    "Rent to Own",
    "Others",
  ];

  var offerT = [
    "For Sale",
    "For Rent",
  ];
  TextEditingController propertyNameController = TextEditingController();
  TextEditingController propertyCostController = TextEditingController();
  TextEditingController pricePerSqmController = TextEditingController();
//  TextEditingController floorAreaController = TextEditingController();
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
