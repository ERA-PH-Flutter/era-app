import 'dart:io';

import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/services/functions.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/services/local_storage.dart';

enum ListingsAState { loading, loaded, error, empty }

enum AddEditListingsStateAd { loading, loaded, location_pick }

class ListingsAdminController extends GetxController {
  AddListingsController addListingsController =
      Get.find<AddListingsController>();
  var addEditListingsStateAd = AddEditListingsStateAd.loading.obs;

  var store = Get.find<LocalStorageService>();
  var listingState = ListingsAState.loading.obs;
  var aiSearchController = TextEditingController();
  RxString price = "".obs;
  var symbol = "PHP ";
  var id = "";

  var data = [].obs;
  var searchQuery = ''.obs;
  var isForSale = 0.obs;
  var isForLease = true.obs;
  Listing? listing;
  //EraUser? user;

  TextEditingController locationController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController propertyNameC = TextEditingController();
  TextEditingController descriptionTitleC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController carouselTitleC = TextEditingController();
  TextEditingController carouselFooterC = TextEditingController();
  TextEditingController allDescriptionC = TextEditingController();
  var currentImage = ''.obs;

  var images = [].obs;
  final picker = ImagePicker();
  final removeImage = false.obs;
  Future getImageGallery() async {
    try {
      final imagePick = await picker.pickMultiImage();
      if (imagePick.isNotEmpty) {
        for (var image in imagePick) {
          images.add(File(image.path));
          if (Get.currentRoute == '/editListings') {
            imagePick.forEach((image) async {
              var a = await CloudStorage().upload(
                  file: File(image.path), target: 'listings/${user!.id}');
              listing?.photos!.add(a);
              await listing!.updateListing();
            });
          }
        }
      }
    } on PlatformException catch (e) {
      return e;
    }
  }

  @override
  void onInit() async {
    data.clear();
    listingState.value = ListingsAState.loaded;
    try {
      if (Get.arguments == null || Get.arguments.isEmpty) {
        var tempData = [];
        for (int i = 0; i < settings!.featuredListings!.length; i++) {
          tempData.add(
              (await Listing().getListing(settings!.featuredListings![i]))
                  .toMap());
        }
        loadData(tempData);
      } else {
        loadData(Get.arguments[0]);
        searchQuery.value = Get.arguments[1];
      }
    } catch (e, ex) {
      print(e);
      print(ex);
      listingState.value = ListingsAState.error;
    }
    super.onInit();
    if (Get.currentRoute == '/editListingsAd') {
      id = Get.arguments[0];
      await assignData();
    } else {
      addEditListingsStateAd.value = AddEditListingsStateAd.loaded;
    }
  }

  @override
  // void onClose() {
  //   //arguments = null;
  //   Get.delete<SearchResultController>(force: true);
  //   super.onClose();
  // }

  loadData(loadedData) {
    loadedData = loadedData ?? [];
    data.value = loadedData.map((d) {
      if (d != null) {
        if (!(d['is_sold'] ?? true)) {
          return d;
        }
      }
    }).toList();
    //data.assignAll(loadedData);
    if (data.isEmpty) {
      listingState.value = ListingsAState.empty;
    } else {
      listingState.value = ListingsAState.loaded;
    }
  }

  assignData() async {
    listing = await Listing().getListing(Get.arguments[0]);
    addListingsController.propertyNameController.text = listing!.name ?? "";
    addListingsController.propertyCostController.text =
        listing!.price == null ? "0" : listing!.price.toString();
    for (int i = 0; i < listing!.photos!.length; i++) {
      images.add(await EraFunctions.urlToFile(listing!.photos![i]));
    }
    addListingsController.pricePerSqmController.text =
        listing!.ppsqm.toString();
    addListingsController.bedsController.text = listing!.beds.toString();
    addListingsController.bathsController.text = listing!.baths.toString();
    addListingsController.carsController.text = listing!.cars.toString();
    addListingsController.areaController.text = listing!.area.toString();
    addListingsController.selectedOfferT.value =
        addListingsController.offerT.contains(listing!.status)
            ? listing!.status
            : null;
    addListingsController.locationController.text = listing!.location ?? "";
    addListingsController.selectedPropertyT.value =
        addListingsController.propertyT.contains(listing!.type)
            ? listing!.type
            : null;
    addListingsController.selectedPropertySubCategory.value =
        addListingsController.subCategory.contains(listing!.subCategory)
            ? listing!.subCategory
            : null;
    addListingsController.descController.text = listing!.description ?? "";
    addListingsController.addressController.text = listing!.address ?? "";
    addListingsController.addEditListingsState.value =
        AddEditListingsState.loaded;
    addListingsController.selectedView.value = listing!.view ?? "SUNRISE";
    addListingsController.addListingsState.value = AddListingsState.loaded;
  }
}
