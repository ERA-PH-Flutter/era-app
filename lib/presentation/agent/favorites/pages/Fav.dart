import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/listings/fav_listing.dart';
import 'package:eraphilippines/app/widgets/listings/gridViewV_Listing.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/listingproperties/pages/property_infomation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/fav_controller.dart';
//todo add text

class Fav extends GetView<FavController> {
  const Fav({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.favState.value) {
                FavState.loading => _loading(),
                FavState.loaded => _loaded(),
                FavState.error => _error(),
                FavState.empty => _empty()
              }),
        ),
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  _loaded() {
    final RealEstateListing? listing = Get.arguments;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Obx(() {
            if (controller.favoritesList.isEmpty && listing == null) {
              return Center(child: Text('No favorites yet.'));
            }

            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: EraText(
                      text: 'MY FAVORITES',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  FavListing(
                    listingModels: controller.favoritesList,
                    // onTap: (RealEstateListing listing) {
                    //   Get.toNamed('/propertyInformation', arguments: listing);
                    // },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  _error() {
    //todo add error screen
  }
  _empty() {
    //todo add empty screen
  }
}
