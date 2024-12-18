import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider_plus/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/propertieslisting.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/quick_links.dart';
import 'package:eraphilippines/app/widgets/web/project_views_web.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:eraphilippines/presentation/website/projects/controllers/project_views_binding.dart';
import 'package:eraphilippines/presentation/website/projects/pages/project_view.dart';
import 'package:eraphilippines/repository/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';
import 'package:eraphilippines/app/models/settings.dart' as era_settings;

import '../../../../app/constants/strings.dart';
import '../../../../app/constants/theme.dart';
import '../../../../repository/listing.dart';
import '../../../../repository/project.dart';

enum HomeWebState { loading, loaded, error, empty }

class HomeWebController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var homelandingState = HomeWebState.loading.obs;

  List<Widget> projects = [];

  var listingImages = [];
  List<Listing> listings = [];
  var news = [];
  Widget? quickLinks;
  final List<String> bannersImages = [];
  final List<Widget> images = [];

  var innerController = CarouselSliderController();
  var carouselC = PageController();
  var carouselIndex = 0.obs;
  @override
  void onInit() async {
    try {
      if (settings != null) {
        if (settings!.banners != null) {
          for (int i = 0; i < settings!.banners!.length; i++) {
            bannersImages.add(settings!.banners![i]);
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
          bannersImages.add(settings!.banners![i]);
        }
      }
      print("banners: ${bannersImages.length}");
      quickLinks = await QuickLinksModel().initialize();
      await getListings();
      await getNews();
      await getImages();
      await getProjects();
      homelandingState.value = HomeWebState.loaded;
    } catch (e) {
      print(e);
      homelandingState.value = HomeWebState.error;
    }
    super.onInit();
  }

  // getBanners() async {
  //   var banners = Get.find<LocalStorageService>().images!['banners'];
  //   if (banners != null) {
  //     for (int i = 0; i < banners.length; i++) {
  //       images.add(Container(
  //         decoration: BoxDecoration(
  //             image: DecorationImage(
  //                 fit: BoxFit.cover, image: FileImage(File(banners[i])))),
  //       ));
  //     }
  //     if (images.isEmpty) {
  //       images.add(Container(
  //         decoration: BoxDecoration(
  //             image: DecorationImage(
  //                 fit: BoxFit.cover,
  //                 image: AssetImage('assets/images/no_image_holder.jpg'))),
  //         //unahin nlg to muna              //wait lg sir dayne ni sesearch ko bat siya ganyan yung no such file or directory
  //       ));
  //     }
  //   } else {
  //     images.add(Container(
  //       decoration: BoxDecoration(
  //           image: DecorationImage(
  //               fit: BoxFit.cover,
  //               image: AssetImage('assets/images/no_image_holder.jpg'))),
  //     ));
  //   }
  // }

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

getProjects() async {
  projects.clear();

  if (settings!.featuredProjects != null) {
    for (int i = 0; i < settings!.featuredProjects!.length; i++) {
      var pr = await Project.getById(settings!.featuredProjects![i]);
      var previewWidgets = ProjectViewsWeb(project: pr).HomebuildPreview();
      projects.addAll(previewWidgets.map((widget) {
        return GestureDetector(
          onTap: () {
            projectArgument = pr;
            HomsController homsController = Get.find<HomsController>();
            selectedIndex.value = 14;
            homsController.onNavbarItemSelected(14);
          },
          child: widget,
        );
      }));
    }
  }
}

}

  // getProjects() async {
  //   projects.clear();
  //   if (settings!.featuredProjects != null) {
  //     for (int i = 0; i < settings!.featuredProjects!.length; i++) {
  //       var pr = await Project.getById(settings!.featuredProjects![i]);
  //       projects.add(GestureDetector(
  //         onTap: () {
  //           //   selectedIndex.value = 14;
  //           // Get.find<HomsController>().onNavbarItemSelected(14);
  //           // Get.to(ProjectViewWeb(),
  //           //     binding: ProjectViewWebBinding(), arguments: pr);
          
  //         },
  //         child: GridView.builder(
  //             shrinkWrap: true,
  //             physics: NeverScrollableScrollPhysics(),
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 3,
  //               crossAxisSpacing: 10.w,
  //               mainAxisSpacing: 10.h,
  //               childAspectRatio: 0.7,
  //             ),
  //             itemCount: ProjectViewsWeb(project: pr).HomebuildPreview().length,
  //             itemBuilder: (context, index) {
  //               return Container(
  //                 child: ProjectViewsWeb(project: pr).HomebuildPreview()[index],
  //               );
  //             }),
  //       ));
  //     }
  //   }
  // }