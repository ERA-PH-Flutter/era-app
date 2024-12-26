import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart'
    as a;
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../app/constants/screens.dart';
import '../../../../../../app/constants/sized_box.dart';
import '../../../controllers/listings_web_controller.dart';
import '../controllers/sold_properties_controller.dart';

class SoldPropertiesWeb extends GetView<SoldPropertiesWebController> {
  const SoldPropertiesWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => switch (controller.soldState.value) {
            SoldState.loading => _loading(),
            SoldState.loaded => _loaded(),
            SoldState.error => _error(),
            SoldState.empty => _empty()
          }),
    );
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    // a.selectedIndex.value = 11;
                    // Get.find<a.HomsController>().onNavbarItemSelected(11);
                    Get.toNamed('/agent-dashboard');
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              EraText(
                text: 'SOLD PROPERTIES',
                fontSize: EraTheme.headerWeb,
                color: AppColors.blue,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          // SoldPropertiesListings(
          //   listingModels: controller.soldListings.value,
          // ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: Get.height,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.soldListings.length,
            itemBuilder: (context, index) {
              Listing listing = controller.soldListings[index];
              return Wrap(
                children: [
                  Container(
                    //margin: EdgeInsets.only(bottom: 16.h),
                    //padding: EdgeInsets.zero,
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
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.delete<ListingsWebController>();
                            Get.toNamed('/view-listing/${listing.id}');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: CloudStorage().imageLoader(
                                      reference: listing.photos != null
                                          ? (listing.photos!.isNotEmpty
                                              ? listing.photos!.first
                                              : AppStrings.noUserImageWhite)
                                          : AppStrings.noUserImageWhite,
                                      height: 350.h,
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                    ),
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
                                        text: '${listing.floorArea} sqm',
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          color: Colors.black,
                          child: GestureDetector(
                            // padding: EdgeInsets.zero,
                            onTap: () async {
                              print('clicked');
                              controller.soldState.value = SoldState.loading;
                              listing.isSold = false;
                              await listing.updateListing();
                              await controller.loadSold();
                              controller.soldState.value = SoldState.loaded;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              color: AppColors.blue,
                              child: EraText(
                                text: 'CLICK TO UNSOLD',
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed('/agent-dashboard');
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black,
                    size: 20.sp,
                  )),
            ],
          ),
          Center(
            child: EraText(
              text: "Nothing is sold in your List!",
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
