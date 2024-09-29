import 'package:carousel_slider_plus/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/models/propertieslisting.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/news.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';
import 'package:eraphilippines/app/models/settings.dart' as era_settings;

import '../../../../app/constants/strings.dart';
import '../../../../repository/listing.dart';

enum HomeWebState { loading, loaded, error, empty }

class HomeWebController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var homelandingState = HomeWebState.loading.obs;
//  final List<String> images = [];
  //final List<String> images = [];
  var listingImages = [];
  List<Listing> listings = [];
  RxList images = [].obs;
  var news = [];

  var innerController = CarouselSliderController();
  var carouselC = PageController();
  var carouselIndex = 0.obs;
  @override
  void onInit() async {
    try {
      // if (settings!.banners != null) {
      //   for (int i = 0; i < settings!.banners!.length; i++) {
      //     images.add(settings!.banners![i]);
      //   }
      // }
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
      await getListings();
      await getNews();

      //  print(images);
      // await getListings();

      //await getImages();
      homelandingState.value = HomeWebState.loaded;
    } catch (e) {
      print(e);
      homelandingState.value = HomeWebState.error;
    }
    super.onInit();
  }

  getNews() async {
    if (settings!.featuredNews!.isNotEmpty) {
      for (int i = 0; i < settings!.featuredNews!.length; i++) {
        settings!.featuredNews![i] != ''
            ? news.add(await News(id: settings!.featuredNews![i]).getNews())
            : null;
      }
    }
  }

  getListings() async {
    if (settings!.featuredListings!.isNotEmpty) {
      for (int i = 0; i < settings!.featuredListings!.length; i++) {
        settings!.featuredListings![i] != ''
            ? listings
                .add(await Listing().getListing(settings!.featuredListings![i]))
            : null;
      }
    }
  }
  // getListings() async {
  //   if (settings!.featuredListings!.isNotEmpty) {
  //     for (int i = 0; i < settings!.featuredListings!.length; i++) {
  //       settings = era_settings.Settings.fromJSON((await FirebaseFirestore
  //               .instance
  //               .collection('settings')
  //               .doc('main')
  //               .get())
  //           .data()!);
  //       for (int i = 0; i < settings!.banners!.length; i++) {
  //         images.add(
  //             await CloudStorage().getFileBytes(docRef: settings!.banners![i]));
  //       }
  //     }
  //   }
  // }

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
}
