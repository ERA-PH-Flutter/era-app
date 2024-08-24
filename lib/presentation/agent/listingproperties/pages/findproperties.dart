import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/custom_pagination.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../searchresult/controllers/searchresult_binding.dart';
import '../../searchresult/pages/searchresult.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoxWidget.build(
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
                      SizedBox(height: 20.h),
                      SearchWidget.build(() {}),
                      SizedBox(height: 10.h),
                    ],
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      quickSearchIcon(AppEraAssets.condo, ()async{
                        var listings = (await FirebaseFirestore.instance.collection('listings').where('type',isEqualTo: 'condominium').get()).docs;
                        var data = listings.map((listing){
                          return listing.data();
                        }).toList();
                        Get.to(() => SearchResult(),
                            binding: SearchResultBinding(),
                            arguments: [data,'All Condominium']);
                      }),
                      SizedBox(width: 15.w),
                      quickSearchIcon(AppEraAssets.condotel, () async {
                        var listings = (await FirebaseFirestore.instance.collection('listings').where('type',isEqualTo: 'condotel').get()).docs;
                        var data = listings.map((listing){
                        return listing.data();
                        }).toList();
                        Get.to(() => SearchResult(),
                        binding: SearchResultBinding(),
                        arguments: [data,'All Condotel']);
                      }),
                      SizedBox(width: 15.w),
                      quickSearchIcon(AppEraAssets.commercial, () async {
                        var listings = (await FirebaseFirestore.instance.collection('listings').where('type',isEqualTo: 'commercial').get()).docs;
                        var data = listings.map((listing){
                        return listing.data();
                        }).toList();
                        Get.to(() => SearchResult(),
                        binding: SearchResultBinding(),
                        arguments: [data,'All Commercial']);
                      }),
                      SizedBox(width: 15.w),
                      quickSearchIcon(AppEraAssets.apartment, () async {
                        var listings = (await FirebaseFirestore.instance.collection('listings').where('type',isEqualTo: 'apartment').get()).docs;
                        var data = listings.map((listing){
                        return listing.data();
                        }).toList();
                        Get.to(() => SearchResult(),
                        binding: SearchResultBinding(),
                        arguments: [data,'All Apartments']);
                      }),
                      SizedBox(width: 15.w),
                      quickSearchIcon(AppEraAssets.house1, () async {
                        var listings = (await FirebaseFirestore.instance.collection('listings').where('type',isEqualTo: 'house').get()).docs;
                        var data = listings.map((listing){
                        return listing.data();
                        }).toList();
                        Get.to(() => SearchResult(),
                        binding: SearchResultBinding(),
                        arguments: [data,'All Houses']);
                      }),
                      SizedBox(width: 15.w),
                      quickSearchIcon(AppEraAssets.land, () async {
                        var listings = (await FirebaseFirestore.instance.collection('listings').where('type',isEqualTo: 'land').get()).docs;
                        var data = listings.map((listing){
                        return listing.data();
                        }).toList();
                        Get.to(() => SearchResult(),
                        binding: SearchResultBinding(),
                        arguments: [data,'All Lands']);
                      }),
                      SizedBox(width: 15.w),
                      quickSearchIcon(AppEraAssets.waterfront, () async {
                        var listings = (await FirebaseFirestore.instance.collection('listings').where('type',isEqualTo: 'water front').get()).docs;
                        var data = listings.map((listing){
                        return listing.data();
                        }).toList();
                        Get.to(() => SearchResult(),
                        binding: SearchResultBinding(),
                        arguments: [data,'All Water Fronts']);
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                /*
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
                SizedBox(height: 10.h),

                //list all properties here
                Button(
                  bgColor: AppColors.kRedColor,
                  text: 'MORE LISTINGS',
                  width: Get.width,
                  fontSize: 23.sp,
                  height: 45.h,
                  fontWeight: FontWeight.w600,
                  onTap: () {
                    // Get.toNamed('/home');
                  },
                ),
                */
                SizedBox(height: 10.h),
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
