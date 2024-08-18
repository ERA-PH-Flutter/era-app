import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/fav/fav_listing.dart';
import 'package:eraphilippines/app/widgets/listings/gridViewV_Listing.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/listingproperties/pages/property_infomation.dart';
import 'package:flutter/cupertino.dart';
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: EraText(
                        text: 'MY FAVORITES',
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blue,
                      ),
                    ),
                    //TO DO: nikko not final this is for sorting
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.h),
                      child: PopupMenuButton<String>(
                        color: AppColors.white,
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.blue),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        icon: Row(
                          children: [
                            EraText(
                              text: 'Sort by',
                              color: AppColors.white,
                              fontSize: 15.sp,
                            ),
                          ],
                        ),
                        onSelected: (String result) {
                          print(result);
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'Category',
                            child: EraText(
                                text: 'Category', color: AppColors.black),
                          ),
                          PopupMenuItem<String>(
                            value: 'date_modified',
                            child:
                                EraText(text: 'Date', color: AppColors.black),
                          ),
                          PopupMenuItem<String>(
                            value: 'Location',
                            child: EraText(
                                text: 'Location', color: AppColors.black),
                          ),
                          PopupMenuItem<String>(
                            value: 'Amount',
                            child:
                                EraText(text: 'Amount', color: AppColors.black),
                          ),
                          const PopupMenuDivider(),
                          const PopupMenuItem<String>(
                            value: 'ascending',
                            child: Text('Ascending'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'descending',
                            child: Text('Descending'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //  DropdownButton<String>(items: controller.sorting.map((listing)), onChanged: onChanged),
                SizedBox(
                  height: 10.h,
                ),
                FavListing(
                  listingModels: controller.favoritesList,
                ),
              ],
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
