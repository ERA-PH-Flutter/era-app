import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/sold_properties/sold_properties_listings.dart';
import 'package:eraphilippines/presentation/agent/soldproperties/controllers/sold_properties_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SoldProperties extends GetView<SoldPropertiesController> {
  const SoldProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.soldState.value) {
                SoldState.loading => _loading(),
                SoldState.loaded => _loaded(),
                SoldState.error => _error(),
                SoldState.empty => _empty()
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 11.h,
            ),
            EraText(
              text: 'SOLD PROPERTIES',
              fontSize: 30.sp,
              color: AppColors.blue,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 5.h,
            ),

            // SoldPropertiesListings(
            //   listingModels: controller.soldListings.value,
            // ),
            ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.soldListings.length,
              itemBuilder: (context, index) {
                Listing listing = controller.soldListings[index];
                return GestureDetector(
                  onTap: () async {
                    await Database().addViews(listing.id);
                    Get.toNamed('/propertyInfo', arguments: listing);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 0),
                              spreadRadius: 1,
                              blurRadius: 10,
                              color: Colors.black12)
                        ]),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: CloudStorage().imageLoader(
                                ref: listing.photos != null
                                    ? (listing.photos!.isNotEmpty
                                        ? listing.photos!.first
                                        : AppStrings.noUserImageWhite)
                                    : AppStrings.noUserImageWhite,
                                width: Get.width,
                                height: 300.h,
                              ),
                            ),
                            SizedBox(
                              height: 17.h,
                            ),
                            Container(
                              width: Get.width,
                              height: 30.h,
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: EraText(
                                textOverflow: TextOverflow.ellipsis,
                                text: listing.name! == ""
                                    ? "No Name"
                                    : listing.name!,
                                fontSize: EraTheme.header - 5.sp,
                                color: AppColors.kRedColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: EraText(
                                text: listing.type!,
                                fontSize: EraTheme.header - 12.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                lineHeight: 1,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      AppEraAssets.area,
                                      width: 55.w,
                                      height: 55.w,
                                    ),
                                    SizedBox(width: 2.w),
                                    EraText(
                                      text: '${listing.area} sqm',
                                      fontSize: EraTheme.paragraph - 1.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10.w),
                                Image.asset(
                                  AppEraAssets.bed,
                                  width: 55.w,
                                  height: 55.w,
                                ),
                                EraText(
                                  text: '${listing.beds}',
                                  fontSize: EraTheme.paragraph - 1.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                                SizedBox(width: 10.w),
                                Image.asset(
                                  AppEraAssets.tub,
                                  width: 55.w,
                                  height: 55.w,
                                ),
                                EraText(
                                  text: '${listing.baths}',
                                  fontSize: EraTheme.paragraph - 1.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                                SizedBox(width: 10.w),
                                Image.asset(
                                  AppEraAssets.car,
                                  width: 55.w,
                                  height: 55.w,
                                ),
                                EraText(
                                  text: '${listing.cars}',
                                  fontSize: EraTheme.paragraph - 1.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: EraText(
                                text: 'Description:',
                                fontSize: EraTheme.header - 8.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                                lineHeight: 1,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: Text(
                                listing.description == ""
                                    ? "No description."
                                    : listing.description!,
                                style: TextStyle(
                                  fontSize: EraTheme.paragraph - 4.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: EraText(
                                text: NumberFormat.currency(
                                        locale: 'en_PH', symbol: 'PHP ')
                                    .format(
                                  listing.price.toString() == ""
                                      ? 0
                                      : listing.price,
                                ),
                                color: AppColors.blue,
                                fontSize: EraTheme.header,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                        Positioned(
                          top: 10.h,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            color: AppColors.kRedColor,
                            child: EraText(
                              text: 'SOLD',
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _error() {
    return Center(
      child: EraText(
        text: "Something went Wrong!",
        color: Colors.black,
      ),
    );
  }

  _empty() {
    return Center(
      child: EraText(
        text: "Nothing is sold in your List!",
        color: Colors.black,
        fontSize: EraTheme.paragraph,
      ),
    );
  }
}
