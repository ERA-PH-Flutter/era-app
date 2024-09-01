import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/ai_search.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/box_widget.dart';

class PropertylistAdmin extends StatelessWidget {
  const PropertylistAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          EraText(
            text: 'PROPERTY LIST',
            fontSize: EraTheme.header,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 20),
          EraText(
            text: ' SEARCH',
            fontSize: EraTheme.header,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 20),
          //PROPERTY LIST
          BoxWidget.build(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        //borderRadius: BorderRadius.circular(10),
                        controller: controller.locationController,
                        hint: 'Location',
                        svgIcon: AppEraAssets.marker,
                        bgColor: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: AppTextField(
                        controller: controller.priceController,
                        hint: 'Price Range',
                        svgIcon: AppEraAssets.money,
                        bgColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: controller.propertyController,
                        hint: 'Property Type',
                        svgIcon: AppEraAssets.house,
                        bgColor: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.9,
                                  child: Radio(
                                      fillColor: WidgetStateProperty.all(
                                          AppColors.white.withOpacity(0.6)),
                                      value: 1,
                                      groupValue: controller.isForSale.value,
                                      onChanged: (value) {
                                        controller.isForSale.value =
                                            value ?? 0;
                                      }),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                EraText(
                                    text: 'BUY',
                                    color: AppColors.white.withOpacity(0.6),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.9,
                                  child: Radio(
                                      fillColor: WidgetStateProperty.all(
                                          AppColors.white.withOpacity(0.6)),
                                      value: 2,
                                      groupValue: controller.isForSale.value,
                                      onChanged: (value) {
                                        controller.isForSale.value =
                                            value ?? 0;
                                      }),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                EraText(
                                    text: 'RENT',
                                    color: AppColors.white.withOpacity(0.6),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: controller.aiSearchController,
                        hint: 'AI Search',
                        svgIcon: AppEraAssets.send,
                        bgColor: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 250.w,
                      child: SearchWidget.build(() async {
                        var data;
                        if (controller.aiSearchController.text == "") {
                          data = await Database().searchListing(
                              location: controller.locationController.text,
                              price: controller.priceController,
                              property: controller.propertyController.text);
                        } else {
                          data = await AI(
                                  query: controller.aiSearchController.text)
                              .search();
                        }
                        Get.toNamed("/searchresult", arguments: [
                          data,
                          controller.aiSearchController.text
                        ]);
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
          SizedBox(height: 20.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                child: TextListing(
                  text: 'QUICK SEARCH',
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kRedColor,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      quickSearchAdmin(AppEraAssets.condo, () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('type', isEqualTo: 'condominium')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Condominium']);
                      }),
                      SizedBox(width: 15.w),
                      quickSearchAdmin(AppEraAssets.condotel, () async {
                        var listings = (await FirebaseFirestore.instance
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
                      quickSearchAdmin(AppEraAssets.commercial, () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('type', isEqualTo: 'commercial')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Commercial']);
                      }),
                      SizedBox(width: 15.w),
                      quickSearchAdmin(AppEraAssets.apartment, () async {
                        var listings = (await FirebaseFirestore.instance
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
                      quickSearchAdmin(AppEraAssets.house1, () async {
                        var listings = (await FirebaseFirestore.instance
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
                      quickSearchAdmin(AppEraAssets.land, () async {
                        var listings = (await FirebaseFirestore.instance
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
                      quickSearchAdmin(AppEraAssets.waterfront, () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('type', isEqualTo: 'water front')
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
              ),
              // PropertiesWidgets(listingsModels: controller.listingImages),
            ],
          ),
          EraText(text: 'NO LISTINGS AVAILABLE', color: AppColors.black),
        ],
      ),
    );
  }

  Widget quickSearchAdmin(String icon, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 120.h,
            width: 120.w,
          ),
        ],
      ),
    );
  }
}
