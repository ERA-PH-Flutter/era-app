import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/ai_search.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/listingproperties/pages/findproperties.dart';
import 'package:eraphilippines/presentation/agent/searchresult/controllers/searchresult_binding.dart';
import 'package:eraphilippines/presentation/agent/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/searchresult/pages/searchresult.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controllers/listing_controller.dart';

class Rental extends GetView<ListingController> {
  const Rental({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchResultController searchController =
        Get.put(SearchResultController());

    return BaseScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(EraTheme.paddingWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoxWidget.build(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      AppTextField(
                        onChange: (value) {
                          print('clicked');
                          searchController.showFullSearch.value =
                              searchController
                                  .aiSearchController.text.isNotEmpty;
                        },
                        onPressed: () {},
                        controller: searchController.aiSearchController,
                        hint: 'AI Search',
                        svgIcon: AppEraAssets.send,
                        bgColor: AppColors.white,
                      ),
                      SizedBox(height: 10.h),
                      Obx(() {
                        if (searchController.showFullSearch.value) {
                          return Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  //Location
                                  AppTextField(
                                    controller:
                                        searchController.locationController,
                                    hint: 'Location',
                                    svgIcon: AppEraAssets.marker,
                                    bgColor: AppColors.white,
                                  ),
                                  //property type
                                  SizedBox(height: 20.h),
                                  AppTextField(
                                    controller:
                                        searchController.propertyController,
                                    hint: 'Property Type',
                                    svgIcon: AppEraAssets.house,
                                    bgColor: AppColors.white,
                                  ),
                                  //price range
                                  SizedBox(height: 20.h),
                                  AppTextField(
                                    controller:
                                        searchController.priceController,
                                    hint: 'Price Range',
                                    svgIcon: AppEraAssets.money,
                                    bgColor: AppColors.white,
                                  ),
                                  //ai search
                                  SizedBox(height: 20.h),

                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 1.9,
                                              child: Radio(
                                                  fillColor: WidgetStateProperty
                                                      .all(AppColors.white
                                                          .withOpacity(0.6)),
                                                  value: 1,
                                                  groupValue: searchController
                                                      .isForSale.value,
                                                  onChanged: (value) {
                                                    searchController.isForSale
                                                        .value = value ?? 0;
                                                  }),
                                            ),
                                            EraText(
                                                text: 'BUY',
                                                color: AppColors.white
                                                    .withOpacity(0.6),
                                                fontSize: 15.0.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 1.9,
                                              child: Radio(
                                                  fillColor: WidgetStateProperty
                                                      .all(AppColors.white
                                                          .withOpacity(0.6)),
                                                  value: 2,
                                                  groupValue: searchController
                                                      .isForSale.value,
                                                  onChanged: (value) {
                                                    searchController.isForSale
                                                        .value = value ?? 0;
                                                  }),
                                            ),
                                            EraText(
                                                text: 'RENT',
                                                color: AppColors.white
                                                    .withOpacity(0.6),
                                                fontSize: 15.0.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: Get.width,
                                    child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                AppColors.white),
                                        shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        openFilterDialog();
                                      },
                                      label: EraText(
                                        text: 'Filters',
                                        color: AppColors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      icon: Icon(
                                        Icons.filter_alt,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  SearchWidget.build(() async {
                                    var data;
                                    if (searchController
                                            .aiSearchController.text ==
                                        "") {
                                      data = await Database().searchListing(
                                          location: searchController
                                              .locationController.text,
                                          price:
                                              searchController.priceController,
                                          type: searchController
                                                      .isForSale.value ==
                                                  1
                                              ? "selling"
                                              : "rent",
                                          property: searchController
                                              .propertyController.text);
                                    } else {
                                      data = await AI(
                                              query: searchController
                                                  .aiSearchController.text)
                                          .search();
                                    }
                                    Get.toNamed("/searchresult",
                                        arguments: [
                                          data,
                                          searchController
                                              .aiSearchController.text
                                        ]);
                                  }),
                                  SizedBox(height: 10.h),
                                ],
                              ),
                            ],
                          );
                        }
                        return Container();
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(() {
                  if (searchController.showFullSearch.value) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextListing(
                            text: 'QUICK RESEARCH',
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kRedColor,
                          ),
                          SizedBox(height: 10.h),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.condo, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('type',
                                              isEqualTo: 'condominium')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Condominium']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.condotel, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('type', isEqualTo: 'condotel')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Condotel']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.commercial, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('type',
                                              isEqualTo: 'commercial')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Commercial']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.apartment, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('type', isEqualTo: 'apartment')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Apartments']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.house1, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('type', isEqualTo: 'house')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Houses']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.land, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('type', isEqualTo: 'land')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Lands']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.waterfront, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('type',
                                              isEqualTo: 'water front')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Water Fronts']);
                                }),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ]);
                  }
                  return Container();
                }),
                SizedBox(height: 10.h),
                EraText(
                  text: 'SEARCH RESULTS FOR',
                  fontSize: 23.sp,
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 10.h),
                EraText(
                  text: '“RENTAL”',
                  fontSize: 22.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
