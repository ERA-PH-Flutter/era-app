import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/services/functions.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../../../app/services/local_storage.dart';

enum ListingsAState { loading, loaded, error, empty }

enum AddEditListingsStateAd { loading, loaded, location_pick }

class ListingsAdminController extends GetxController {
  AddListingsController addListingsController =
      Get.put(AddListingsController());
  var addEditListingsStateAd = AddEditListingsStateAd.loading.obs;
  var paginator = NumberPaginatorController();
  var store = Get.find<LocalStorageService>();
  var listingState = ListingsAState.loading.obs;
  var aiSearchController = TextEditingController();
  RxString price = "".obs;
  var symbol = "PHP ";
  var id = "";
  final isLoading = true.obs;

  var data = [].obs;
  var searchQuery = ''.obs;
  var isForSale = 0.obs;
  var isForLease = true.obs;
  Listing? listing;
  List<Listing> listings = [];
  var projectLego = [].obs;
  TextEditingController projectTitleController = TextEditingController();

  TextEditingController developerController = TextEditingController();
  TextEditingController virtualTitleController = TextEditingController();
  TextEditingController virtualParagraphController = TextEditingController();
  TextEditingController virtualLinkController = TextEditingController();
  TextEditingController carouselTitleController = TextEditingController();
  TextEditingController carouselParagraphController = TextEditingController();
  TextEditingController carouselFloorAreaC = TextEditingController();
  TextEditingController carouselnumberOfBedC = TextEditingController();
  TextEditingController carouselLoggiaSizeC = TextEditingController();

  // var innerController = CarouselSliderController();
  // var carouselIndex = 0.obs;

  var carouselFa = ''.obs;
  var carouselNob = ''.obs;
  var carouselLs = ''.obs;

  void addcarouselFa(String floorArea) {
    carouselFa.value = floorArea;
  }

  void addNob(String nob) {
    carouselNob.value = nob;
  }

  void addcarouselLs(String ls) {
    carouselLs.value = ls;
  }

  var addBlurbTitle = <String>[].obs;
  var addBlurbParagraph = <String>[].obs;
  var addBlurImage = <Uint8List?>[].obs;

  var blurbTitleController = <TextEditingController>[].obs;
  var blurbParagraphController = <TextEditingController>[].obs;

  var blurbTitle = TextEditingController();
  var blurbParagraph = TextEditingController();

  var selectedOption = ''.obs;

  var carousel = <Uint8List>[].obs;
  var selectedIndoor = ''.obs;
  var selectedOutDoor = ''.obs;
  var bannerPhotos = <Uint8List>[].obs;
  var projectLogo = <Uint8List>[].obs;
  var developerName = ''.obs;
  var virtualTitle = ''.obs;
  var virtualParagraph = ''.obs;
  var virtualLink = ''.obs;
  // discover our spaces
  var carouselTitle = ''.obs;
  var carouselParagraph = ''.obs;

  void addCarouselTitle(String title) {
    carouselTitle.value = title;
  }

  void addCarouselDesc(String title) {
    carouselParagraph.value = title;
  }

  void addCarouselPhoto(Uint8List image) {
    carousel.add(image);
  }
  //amenities

  var addOutDoorTitle = <String>[].obs;
  var addOutDoorParagraph = <String>[].obs;
  var addOutDoorImage = <Uint8List?>[].obs;

//for gallery images in the amenities
  var outdoorAmenities = <Uint8List>[].obs;
  var indoorAmenities = <Uint8List>[].obs;

  void addoutdoorAmenitiesBlurb() {
    addOutDoorTitle.add('');
    addBlurbParagraph.add('');
    addOutDoorImage.add(null);

    blurbTitleController.add(TextEditingController());
    blurbParagraphController.add(TextEditingController());
  }

  void addBlurb() {
    addBlurbTitle.add('');
    addBlurbParagraph.add('');
    addBlurImage.add(null);
    blurbTitleController.add(TextEditingController());
    blurbParagraphController.add(TextEditingController());
  }

  void updateBlurbTitle(int index, String title) {
    addBlurbTitle[index] = title;
    addBlurbTitle.refresh();
  }

  void updateBlurbImage(int index, Uint8List? image) {
    addBlurImage[index] = image;
    addBlurImage.refresh();
  }

  void updateBlurbParagraph(int index, String paragraph) {
    addBlurbParagraph[index] = paragraph;
    addBlurbParagraph.refresh();
  }

  void removeBlurb(int index) {
    addBlurbTitle.removeAt(index);
    addBlurbParagraph.removeAt(index);
    addBlurImage.removeAt(index);

    blurbTitleController[index].dispose();
    blurbParagraphController[index].dispose();
    blurbTitleController.removeAt(index);
    blurbParagraphController.removeAt(index);
  }

  @override
  void onClose() {
    for (var controller in blurbTitleController) {
      controller.dispose();
    }
    for (var controller in blurbParagraphController) {
      controller.dispose();
    }
    super.onClose();
  }

  uploadSingle(file) async {
    return await CloudStorage()
        .uploadFromMemory(file: file, target: 'projects');
  }

  Future<int> getOrderCount()async{
    try {
      return (await FirebaseFirestore
          .instance
          .collection('projects').orderBy('order_id')
          .get()).docs.last.data()['order_id'].toString().toInt() + 1;
    }catch(e){
      return 1;
    }
  }

  uploadMultiple(files) async {
    var newImages = [];
    for (var image in files) {
      newImages.add(await CloudStorage()
          .uploadFromMemory(file: image, target: 'projects'));
    }
    return newImages;
  }

  void updateDeveloperName(String name) {
    developerName.value = name;
  }

  void updateVirtualTitle(String title) {
    virtualTitle.value = title;
  }

  void updateVirtualParagaph(String paragraph) {
    virtualParagraph.value = paragraph;
  }

  void addProjectPhoto(Uint8List image) {
    projectLogo.add(image);
  }

  void addBannerPhoto(Uint8List bannerImage) {
    bannerPhotos.add(bannerImage);
  }

  void addoutdoorAmenities(Uint8List image) {
    outdoorAmenities.add(image);
  }

  void addindoorAmenities(Uint8List image) {
    indoorAmenities.add(image);
  }

  void removeProjectPhoto() {
    projectLogo.clear();
    bannerPhotos.clear();
  }

  //EraUser? user;
  //EraUser? user;

//   TextEditingController locationController = TextEditingController();
//   TextEditingController propertyController = TextEditingController();
//   TextEditingController priceController = TextEditingController();

//   //projects
//   TextEditingController propertyNameController = TextEditingController();
//   TextEditingController developerController = TextEditingController();
//   TextEditingController featuredPhotosController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();

//   TextEditingController addFeaturedDesc1 = TextEditingController();
//   TextEditingController addFeaturedDesc2 = TextEditingController();
//   TextEditingController addFeaturedDesc3 = TextEditingController();
//   TextEditingController addFeaturedDesc4 = TextEditingController();

//   TextEditingController outdoorAmenitiesController = TextEditingController();
//   TextEditingController indoorAmenitiesController = TextEditingController();

//   TextEditingController locationControllers = TextEditingController();

//   TextEditingController areaController = TextEditingController();
//   TextEditingController roomController = TextEditingController();
//   TextEditingController balconyController = TextEditingController();
//   TextEditingController areaController1 = TextEditingController();
//   TextEditingController roomController2 = TextEditingController();
//   TextEditingController balconyController3 = TextEditingController();
//   TextEditingController areaController4 = TextEditingController();
//   TextEditingController roomController5 = TextEditingController();
//   TextEditingController balconyController6 = TextEditingController();

//   TextEditingController carouselDesc = TextEditingController();
//   TextEditingController carouselDesc2 = TextEditingController();
//   TextEditingController carouselDesc3 = TextEditingController();

// //
//   TextEditingController vrUploadController = TextEditingController();
//   TextEditingController vrUploadController2 = TextEditingController();

  TextEditingController locationController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
//   TextEditingController propertyNameC = TextEditingController();
//   TextEditingController descriptionTitleC = TextEditingController();
//   TextEditingController descriptionC = TextEditingController();
//   TextEditingController carouselTitleC = TextEditingController();
//   TextEditingController carouselFooterC = TextEditingController();
//   TextEditingController allDescriptionC = TextEditingController();
  var currentImage = <Uint8List>[].obs;
  Stream<QuerySnapshot<Map<String, dynamic>>> streamSearch = FirebaseFirestore
      .instance
      .collection('listings')
      .orderBy('date_created')
      .snapshots();

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
            for (var image in imagePick) {
              var a = await CloudStorage().upload(
                  file: File(image.path), target: 'listings/${user!.id}');
              listing?.photos!.add(a);
              await listing!.updateListing();
            }
          }
        }
      }
    } on PlatformException catch (e) {
      return e;
    }
  }
  var oldImages = [];
  @override
  void onInit() async {
    if (projectsData != null) {
      for (int i = 0; i < projectsData!.length; i++) {
        if (['Banner Images', 'Project Logo', 'Blurb']
            .contains(projectsData![i]['type'])) {
          oldImages.add(projectsData![i]['image']);
          projectsData![i]['image'] = await CloudStorage().getFileBytes(docRef: projectsData![i]['image']);
        } else if (['Carousel'].contains(projectsData![i]['type'])) {
          oldImages += projectsData![i]['images'];
          projectsData![i]['images'] = await CloudStorage().getFilesBytes(docRefs: projectsData![i]['images']);
        } else if (['Outdoor Amenities', 'Indoor Amenities'].contains(projectsData![i]['type'])) {
          if (projectsData?[i]['sub_type'] == 'blurb') {
            oldImages.add(projectsData![i]['image']);
            projectsData![i]['image'] = await CloudStorage().getFileBytes(docRef: projectsData![i]['image']);
          } else {
            oldImages += projectsData![i]['images'];
            projectsData![i]['images'] = await CloudStorage().getFilesBytes(docRefs: projectsData?[i]['images']);
          }
        }
      }
      projectLego.value = projectsData!;
    }
    if (!kIsWeb) {
      data.clear();
      //listingState.value = ListingsAState.loaded;
      try {
        if (Get.arguments == null) {
          var tempData = [];
          tempData = (await FirebaseFirestore.instance
                  .collection('listings')
                  .limit(10)
                  .get())
              .docs
              .map((doc) {
            return doc.data();
          }).toList();
          print(tempData);
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
    else {
      listingState.value = ListingsAState.loaded;
      addEditListingsStateAd.value = AddEditListingsStateAd.loaded;
    }
  }

  loadData(loadedData) {
    loadedData = loadedData ?? [];
    loadedData.forEach((d) {
      if (d != null) {
        if (!(d['is_sold'] ?? true)) {
          data.add(d);
        }
      }
    });
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

  Stream<QuerySnapshot<Map<String, dynamic>>> searchStream() {
    if (aiSearchController.text.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection('listings')
          .where('name',
              isGreaterThanOrEqualTo: aiSearchController.text.capitalize)
          .where('name',
              isLessThanOrEqualTo:
                  '${aiSearchController.text.capitalize}\uf8ff')
          .snapshots();
    } else if (locationController.text.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection('listings')
          .where('location', isGreaterThanOrEqualTo: locationController.text)
          .where('location',
              isLessThanOrEqualTo: '${locationController.text}\uf8ff')
          .snapshots();
    } else if (priceController.text.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection('listings')
          .where('price', isLessThanOrEqualTo: priceController.text.toInt())
          .snapshots();
    } else if (propertyController.text.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection('listings')
          .where('type',
              isGreaterThanOrEqualTo: propertyController.text.capitalizeFirst)
          .where('type',
              isLessThanOrEqualTo:
                  '${propertyController.text.capitalizeFirst}\uf8ff')
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('listings')
          .orderBy('date_created')
          .snapshots();
    }
  }

  loadWeb(link, webViewController) async {
    await webViewController.loadRequest(Uri.parse(
        "https://api.eraphilippines.com/proxy.php?url=${base64Encode(link)}"));
    return true;
  }
}
