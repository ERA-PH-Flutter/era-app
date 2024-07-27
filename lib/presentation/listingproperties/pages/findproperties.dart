import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/findingproperties.dart';
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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BoxWidget(
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        //Location
                        AppTextField(
                          hint: 'Location',
                          svgIcon: 'assets/icons/marker.png',
                          bgColor: AppColors.white,
                        ),
                        //property type
                        SizedBox(height: 20.h),
                        AppTextField(
                          hint: 'Property Type',
                          svgIcon: 'assets/icons/house.png',
                          bgColor: AppColors.white,
                        ),
                        //price range
                        SizedBox(height: 20.h),
                        AppTextField(
                          hint: 'Price Range',
                          svgIcon: 'assets/icons/money.png',
                          bgColor: AppColors.white,
                        ),
                        //ai search
                        SizedBox(height: 20.h),
                        AppTextField(
                          hint: 'AI Search',
                          svgIcon: 'assets/icons/send.png',
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
                        SearchWidget(),
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
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        quickSearchIcon('assets/icons/__Condominium.png', () {
                          Get.toNamed('/project');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon('assets/icons/__Condotel.png', () {
                          Get.toNamed('/home');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon('assets/icons/__Commercial.png', () {
                          Get.toNamed('/home');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon('assets/icons/__Apartment.png', () {
                          Get.toNamed('/home');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon('assets/icons/__House.png', () {
                          Get.toNamed('/home');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon('assets/icons/__Land.png', () {
                          Get.toNamed('/home');
                        }),
                        SizedBox(width: 15.w),
                        quickSearchIcon('assets/icons/__Waterfront.png', () {
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
