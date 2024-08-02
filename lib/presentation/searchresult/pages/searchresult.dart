import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/Listing_items.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/findingproperties.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/base/controllers/base_controller.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:eraphilippines/presentation/searchresult/controllers/searchresult_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/widgets/listedBy_widget.dart';

class SearchResult extends GetView<SearchResultController> {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Obx(() => switch (controller.searchResultState.value) {
                SearchResultState.loading => Center(
                    child: CircularProgressIndicator(),
                  ),
                SearchResultState.loaded => _loaded(),
                SearchResultState.empty => _empty(),
                SearchResultState.searching => _searching(),
                SearchResultState.error => _error(),
              }),
        ),
      ),
    );
  }

  _searching() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoxWidget.build(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              AppTextField(
                hint: 'AI Search',
                svgIcon: 'assets/icons/send.png',
                bgColor: AppColors.white,
              ),
              SearchWidget.build(() {}),
            ],
          ),
        ),
      ],
    );
  }

  _loaded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoxWidget.build(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              AppTextField(
                hint: 'AI Search',
                svgIcon: 'assets/icons/send.png',
                bgColor: AppColors.white,
              ),
              SearchWidget.build(() {}),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: EraText(
            text: 'SEARCH RESULTS FOR',
            fontSize: 23.sp,
            color: AppColors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: EraText(
            text: '“Lorem ipsum dolor sit amet”',
            fontSize: 22.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        ListView.builder(
          shrinkWrap: true,
          itemCount: controller.data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                //Get.toNamed('/propertyInfo', arguments: listingItems);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        "assets/images/image2.png",
                        fit: BoxFit.cover,
                        width: 380.w,
                        height: 200.h,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: EraText(
                        text: controller.data[index]["type"],
                        fontSize: 16.sp,
                        color: AppColors.kRedColor,
                        fontWeight: FontWeight.bold,
                        lineHeight: 0.4,
                      ),
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/floor-area.png",
                              width: 40.w,
                              height: 40.h,
                            ),
                            SizedBox(width: 2.w),
                            EraText(
                              text: '${controller.data[index]["size"]} sqm',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                        SizedBox(width: 10.w),
                        Image.asset(
                          AppEraAssets.area,
                          width: 40.w,
                          height: 40.h,
                        ),
                        EraText(
                          text: '${controller.data[index]["rooms"]}',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                        SizedBox(width: 10.w),
                        Image.asset(
                          "assets/icons/tub.png",
                          width: 40.w,
                          height: 40.h,
                        ),
                        EraText(
                          text: '${controller.data[index]["baths"]}',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                        SizedBox(width: 10.w),
                        Image.asset(
                          "assets/icons/car.png",
                          width: 40.w,
                          height: 40.h,
                        ),
                        EraText(
                          text: '${controller.data[index]["garage"]}',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: EraText(
                        text: 'Description:',
                        fontSize: 16.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        lineHeight: 1,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        controller.data[index]["description"] ??
                            "Nothing added.",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: EraText(
                        text: NumberFormat.currency(
                                locale: 'en_PH', symbol: 'PHP ')
                            .format(
                          controller.data[index]["price"],
                        ),
                        color: AppColors.blue,
                        fontSize: 23.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //widget listed by
                    /*
                     ListedBy(
                       text: 'Listed By',
                       image: ,
                       agentFirstName: listingItems.agentFirstName,
                       agentLastName: listingItems.agentLastName,
                       agentType: listingItems.agents,
                     ),
                     */
                  ],
                ),
              ),
            );
            //todo missy
          },
        )
      ],
    );
  }

  _error() {}

  _empty() {
    return Container();
  }
}
