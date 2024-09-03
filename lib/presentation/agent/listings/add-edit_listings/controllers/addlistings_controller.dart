import 'dart:io';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_location_picker/map_location_picker.dart';

import '../../../../../app/services/local_storage.dart';
import '../../../../../repository/listing.dart';

enum AddListingsState { loading, loaded, location_pick }

enum AddEditListingsState { loading, loaded, location_pick }

class AddListingsController extends GetxController with BaseController {
  var store = Get.find<LocalStorageService>();
  var addEditListingsState = AddEditListingsState.loading.obs;
  var addListingsState = AddListingsState.loading.obs;
  var id = "";
  RxSet<Marker> marker = {Marker(markerId: MarkerId("aaaa"))}.obs;
  var address = "".obs;
  var add;
  RxList images = [].obs;
  final picker = ImagePicker();
  final removeImage = false.obs;
  var selectedPropertyT = RxnString();
  var selectedOfferT = RxnString();
  var selectedPropertySubCategory = RxnString();
  var selectedView = RxnString();
  Listing? listing;

  generateMarker(position) async {
    marker?.value = {
      Marker(
          anchor: const Offset(0.5, 0.5),
          draggable: true,
          markerId: MarkerId("aaaa1"),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed))
    };
  }

  var viewL = [
    "SUNSET",
    "SUNRISE",
  ];

  var subCategory = [
    "Agricultural",
    "Apartment",
    "Commercial",
    "Condominium",
    "Factory",
    "Farm",
    "Hotel",
    "House and Lot",
    "House",
    "Lot",
    "Industrial Lot",
    "Office",
    "Parking Slot",
    "Residential",
    "Resort",
    "Townhouse",
    "Warehouse",
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
  //addController
  LatLng? latLng;
  TextEditingController propertyNameController = TextEditingController();
  TextEditingController propertyCostController = TextEditingController();
  TextEditingController pricePerSqmController = TextEditingController();
  TextEditingController bedsController = TextEditingController();
  TextEditingController bathsController = TextEditingController();
  TextEditingController carsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController offerTypeController = TextEditingController();
  TextEditingController viewController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController propertyTypeController = TextEditingController();
  TextEditingController propertySubCategoryController = TextEditingController();
  TextEditingController descController = TextEditingController();

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

  onInit() async {
    super.onInit();
    if (Get.currentRoute == '/editListings') {
      id = Get.arguments[0];
      await assignData();
    } else {
      addEditListingsState.value = AddEditListingsState.loaded;
    }
  }

  @override
  onClose() {
    Get.delete<AddListingsController>();
    super.onClose;
  }

  assignData() async {
    listing = await Listing().getListing(Get.arguments[0]);
    propertyNameController.text = listing!.name ?? "";
    propertyCostController.text =
        listing!.price == null ? "0" : listing!.price.toString();
    for (int i = 0; i < listing!.photos!.length; i++) {
      images.add(await urlToFile(listing!.photos![i]));
    }
    pricePerSqmController.text = listing!.ppsqm.toString();
    bedsController.text = listing!.beds.toString();
    bathsController.text = listing!.baths.toString();
    carsController.text = listing!.cars.toString();
    areaController.text = listing!.area.toString();
    selectedOfferT.value =
        offerT.contains(listing!.status) ? listing!.status : null;
    locationController.text = listing!.location ?? "";
    selectedPropertyT.value =
        propertyT.contains(listing!.type) ? listing!.type : null;
    selectedPropertySubCategory.value =
        subCategory.contains(listing!.subCategory)
            ? listing!.subCategory
            : null;
    descController.text = listing!.description ?? "";
    addressController.text = listing!.address ?? "";
    addEditListingsState.value = AddEditListingsState.loaded;
    selectedView.value = listing!.view ?? "SUNRISE";
    addListingsState.value = AddListingsState.loaded;
  }
}
