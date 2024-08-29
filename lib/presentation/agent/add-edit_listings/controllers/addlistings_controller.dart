import 'dart:io';
import 'dart:math';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/listing.dart';


enum AddListingsState {
  loading,
  loaded,
  error,
}
enum AddEditListingsState {loading,loaded}
class AddListingsController extends GetxController with BaseController {
  var store = Get.find<LocalStorageService>();
  var addEditListingsState = AddEditListingsState.loading.obs;
  var id = "";
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
  //addController

  TextEditingController propertyNameController = TextEditingController();
  TextEditingController propertyCostController = TextEditingController();
  TextEditingController pricePerSqmController = TextEditingController();
  TextEditingController bedsController = TextEditingController();
  TextEditingController bathsController = TextEditingController();
  TextEditingController carsController = TextEditingController();

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
  onInit()async{
    super.onInit();
    print(Get.currentRoute == '/editListings');
    if(Get.currentRoute == '/editListings'){
      print(id);
      id = Get.arguments[0];
      await assignData();
    }
  }
  @override
  onClose(){
    Get.delete<AddListingsController>();
    super.onClose;
  }
  assignData()async{

    Listing listing = await Listing().getListing(Get.arguments[0]);
    propertyNameController.text = listing.name ?? "";
    propertyCostController.text = listing.price == null ?  "0" : listing.price.toString();
    for(int i = 0; i <  listing.photos!.length;i++){
      images.add( await urlToFile(listing.photos![i]));
    }
    pricePerSqmController.text = listing.ppsqm.toString();
    bedsController.text =listing.beds.toString();
    bathsController.text = listing.baths.toString();
    carsController.text =listing.cars.toString();
    areaController.text = listing.area.toString();
    selectedOfferT.value = offerT.contains(listing.status) ? listing.status : null;
    locationController.text = listing.location ?? "";
    selectedPropertyT.value = propertyT.contains(listing.type) ? listing.type : null;
    selectedPropertySubCategory.value = subCategory.contains( listing.subCategory) ?  listing.subCategory : null;
    descController.text = listing.description ?? "";
    addEditListingsState.value = AddEditListingsState.loaded;
  }
}
