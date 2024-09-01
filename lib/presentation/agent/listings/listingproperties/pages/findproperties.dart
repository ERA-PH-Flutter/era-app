import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/services/ai_search.dart';
import '../../../../../app/services/firebase_database.dart';
import '../controllers/listing_controller.dart';

class FindProperties extends GetView<ListingController> {
  const FindProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(EraTheme.paddingWidth),
            child:  Column(
              children: [
                BoxWidget.build(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      //Location
                      AppTextField(
                        controller: controller.locationController,
                        hint: 'Location',
                        svgIcon: AppEraAssets.marker,
                        bgColor: AppColors.white,
                      ),
                      //property type
                      SizedBox(height: 20.h),
                      AppTextField(
                        controller: controller.propertyController,
                        hint: 'Property Type',
                        svgIcon: AppEraAssets.house,
                        bgColor: AppColors.white,
                      ),
                      //price range
                      SizedBox(height: 20.h),
                      AppTextField(
                        controller: controller.priceController,
                        hint: 'Price Range',
                        svgIcon: AppEraAssets.money,
                        bgColor: AppColors.white,
                      ),
                      //ai search
                      SizedBox(height: 20.h),
                      AppTextField(
                        controller: controller.aiSearchController,
                        hint: 'AI Search',
                        svgIcon: AppEraAssets.send,
                        bgColor: AppColors.white,
                      ),
                      SizedBox(height: 20.h),
                      Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.9,
                                  child: Radio(
                                      toggleable: true,
                                      fillColor: WidgetStateProperty.all(
                                          AppColors.white.withOpacity(0.6)),
                                      value: 1,
                                      groupValue: controller.isForSale.value,
                                      onChanged: (value) {
                                        controller.isForSale.value = value ?? 0;
                                      }),
                                ),
                                EraText(
                                    text: 'BUY',
                                    color: AppColors.white.withOpacity(0.6),
                                    fontSize: 15.0.sp,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.9,
                                  child: Radio(
                                      toggleable: true,
                                      fillColor: WidgetStateProperty.all(
                                          AppColors.white.withOpacity(0.6)),
                                      value: 2,
                                      groupValue: controller.isForSale.value,
                                      onChanged: (value) {
                                        controller.isForSale.value = value ?? 0;
                                      }),
                                ),
                                EraText(
                                    text: 'RENT',
                                    color: AppColors.white.withOpacity(0.6),
                                    fontSize: 15.0.sp,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: Get.width,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                            WidgetStateProperty.all(AppColors.white),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
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
                        var searchQuery = "";
                        if (controller.isForSale.value == 1) {
                          data = await Database().getForSaleListing();
                          searchQuery = "All For Sale Listings";
                        } else if (controller.isForSale.value == 2) {
                          data = await Database().getForRentListing();
                          searchQuery = "All For Rent Listings";
                        } else if (controller.aiSearchController.text == "") {
                          data = await Database().searchListing(
                              location: controller.locationController.text,
                              price: controller.priceController.text,
                              property: controller.propertyController.text);
                          if(controller.locationController.text != ""){
                            searchQuery += "Location: ${controller.locationController.text}";
                          }else if(controller.propertyController.text != ""){
                            searchQuery += "Property Type: ${controller.locationController.text}";
                          }else if(controller.priceController.text != ""){
                            searchQuery += "With price less than: ${controller.priceController.text}";
                          }
                        } else {
                          data =
                          await AI(query: controller.aiSearchController.text)
                              .search();
                          searchQuery = controller.aiSearchController.text;
                        }
                        selectedIndex.value = 2;
                        Get.toNamed("/searchresult",
                            arguments: [data, searchQuery]);
                      }),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextListing(
                      text: 'QUICK SEARCH',
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kRedColor,
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FindProperties.quickSearchIcon(AppEraAssets.condo,
                                    () async {
                                  var listings = (await FirebaseFirestore.instance
                                      .collection('listings')
                                      .where('type', isEqualTo: 'Condominium')
                                      .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Condominium']);
                                }),
                            SizedBox(width: 15.w),
                            FindProperties.quickSearchIcon(AppEraAssets.condotel,
                                    () async {
                                  var listings = (await FirebaseFirestore.instance
                                      .collection('listings')
                                      .where('type', isEqualTo: 'Condotel')
                                      .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Condotel']);
                                }),
                            SizedBox(width: 15.w),
                            FindProperties.quickSearchIcon(AppEraAssets.commercial,
                                    () async {
                                  var listings = (await FirebaseFirestore.instance
                                      .collection('listings')
                                      .where('type', isEqualTo: 'Commercial')
                                      .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Commercial']);
                                }),
                            SizedBox(width: 15.w),
                            FindProperties.quickSearchIcon(AppEraAssets.apartment,
                                    () async {
                                  var listings = (await FirebaseFirestore.instance
                                      .collection('listings')
                                      .where('sub_category', isEqualTo: 'Apartment')
                                      .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Apartments']);
                                }),
                            SizedBox(width: 15.w),
                            FindProperties.quickSearchIcon(AppEraAssets.house1,
                                    () async {
                                  var listings = (await FirebaseFirestore.instance
                                      .collection('listings')
                                      .where('sub_category', isEqualTo: 'House')
                                      .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Houses']);
                                }),
                            SizedBox(width: 15.w),
                            FindProperties.quickSearchIcon(AppEraAssets.land,
                                    () async {
                                  var listings = (await FirebaseFirestore.instance
                                      .collection('listings')
                                      .where('sub_category', isEqualTo: 'Lot')
                                      .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Lands']);
                                }),
                            SizedBox(width: 15.w),
                            FindProperties.quickSearchIcon(AppEraAssets.waterfront,
                                    () async {
                                  var listings = (await FirebaseFirestore.instance
                                      .collection('listings')
                                      .where('view', isEqualTo: 'Water Front')
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget quickSearchIcon(String icon, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 80.h,
            width: 80.w,
          ),
        ],
      ),
    );
  }
}
