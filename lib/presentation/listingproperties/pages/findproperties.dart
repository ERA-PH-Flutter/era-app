import 'dart:ffi';

import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/custom_pagination.dart';
import 'package:eraphilippines/app/widgets/listings/gridViewV_Listing.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/listingproperties/controllers/listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FindProperties extends GetView<ListingController> {
  const FindProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BoxWidget.build(
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        //Location
                        AppTextField(
                          hint: 'Location',
                          svgIcon: AppEraAssets.marker,
                          bgColor: AppColors.white,
                        ),
                        //property type
                        SizedBox(height: 20.h),
                        AppTextField(
                          hint: 'Property Type',
                          svgIcon: AppEraAssets.house,
                          bgColor: AppColors.white,
                        ),
                        //price range
                        SizedBox(height: 20.h),
                        AppTextField(
                          hint: 'Price Range',
                          svgIcon: AppEraAssets.money,
                          bgColor: AppColors.white,
                        ),
                        //ai search
                        SizedBox(height: 20.h),
                        AppTextField(
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
                                        fillColor: WidgetStateProperty.all(
                                            AppColors.white.withOpacity(0.6)),
                                        value: 1,
                                        groupValue: controller.isForSale.value,
                                        onChanged: (value) {
                                          controller.isForSale.value =
                                              value ?? 0;
                                        }),
                                  ),
                                  EraText(
                                      text: 'SELL',
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
                                        fillColor: WidgetStateProperty.all(
                                            AppColors.white.withOpacity(0.6)),
                                        value: 2,
                                        groupValue: controller.isForSale.value,
                                        onChanged: (value) {
                                          controller.isForSale.value =
                                              value ?? 0;
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
                        SearchWidget.build(() {}),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                TextListing(
                  text: 'QUICK RESEARCH',
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kRedColor,
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        quickSearchIcon(AppEraAssets.condo, () {
                          Get.toNamed('/project');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon(AppEraAssets.condotel, () {
                          Get.toNamed('/home');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon(AppEraAssets.commercial, () {
                          Get.toNamed('/home');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon(AppEraAssets.apartment, () {
                          Get.toNamed('/home');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon(AppEraAssets.house1, () {
                          Get.toNamed('/home');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon(AppEraAssets.land, () {
                          Get.toNamed('/home');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon(AppEraAssets.waterfront, () {
                          Get.toNamed('/home');
                        }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                TextListing(
                    text: 'FEATURED LISTINGS',
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kRedColor),
                SizedBox(height: 10.h),
                //not done with the pagination design i think i might change it..
                CustomPaginator(
                    totalPages: controller.totalPages,
                    currentPage: controller.currentPage,
                    onPageSelected: controller.onPageSelected),
                //list all properties here
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FindingProperties(
                    listingModels: RealEstateListing.listingsModels,
                  ),
                ),
                Button(
                  bgColor: AppColors.kRedColor,
                  text: 'MORE LISTINGS',
                  width: 320.w,
                  fontSize: 23.sp,
                  height: 45.h,
                  fontWeight: FontWeight.w600,
                  onTap: () {
                    // Get.toNamed('/home');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget quickSearchIcon(String icon, Function()? onTap) {
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
