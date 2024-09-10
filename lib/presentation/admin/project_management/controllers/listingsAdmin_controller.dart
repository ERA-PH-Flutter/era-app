import 'dart:io';

import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/services/functions.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
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

class ListingsAdminController extends GetxController with BaseController {
  AddListingsController addListingsController =
      Get.put(AddListingsController());
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

  //projects
  TextEditingController propertyNameController = TextEditingController();
  TextEditingController developerController = TextEditingController();
  TextEditingController featuredPhotosController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TextEditingController addFeaturedDesc1 = TextEditingController();
  TextEditingController addFeaturedDesc2 = TextEditingController();
  TextEditingController outdoorAmenitiesController = TextEditingController();
  TextEditingController indoorAmenitiesController = TextEditingController();

  TextEditingController locationControllers = TextEditingController();

  TextEditingController areaController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController balconyController = TextEditingController();
  TextEditingController areaController1 = TextEditingController();
  TextEditingController roomController2 = TextEditingController();
  TextEditingController balconyController3 = TextEditingController();
  TextEditingController areaController4 = TextEditingController();
  TextEditingController roomController5 = TextEditingController();
  TextEditingController balconyController6 = TextEditingController();
  TextEditingController vrUploadController = TextEditingController();

  TextEditingController carouselDesc = TextEditingController();
  TextEditingController carouselDesc2 = TextEditingController();
  TextEditingController carouselDesc3 = TextEditingController();

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
}
