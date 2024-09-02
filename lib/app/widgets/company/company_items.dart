import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

var selectedIndex = 0.obs;

void nextImage(int totalImg) {
  if (selectedIndex.value < totalImg - 1) {
    selectedIndex.value++;
  }
}

void prevImage() {
  if (selectedIndex.value > 0) {
    selectedIndex.value--;
  }
}

class CompanyItems extends StatelessWidget {
  final companyItems;
  final bool showListedby;

  const CompanyItems({
    super.key,
    required this.companyItems,
    required this.showListedby,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CloudStorage().imageLoader(
              ref: companyItems.image,
              height: 250.h,
            ),
            Spacer(),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 270.h,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    spreadRadius: 60.w,
                    blurRadius: 8.w,
                    offset: Offset(0, 8.h))
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 30.w,
          right: 40.w,
          top: 195.h,
          child: Card(
            color: AppColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: EraTheme.paddingWidthSmall, vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EraText(
                    text: companyItems.title,
                    fontSize: EraTheme.paragraph + 4.sp,
                    color: AppColors.kRedColor,
                    fontWeight: FontWeight.bold,
                    textOverflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  EraText(
                    text: companyItems.description,
                    fontSize: EraTheme.paragraph,
                    color: Colors.black,
                    maxLines: 3,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  Button(
                    text: 'READ MORE',
                    onTap: () {
                      Get.toNamed("/aboutus");
                    },
                    bgColor: AppColors.kRedColor,
                    height: 30.h,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showListedby == true)
          Positioned(
            left: 10.w,
            top: 0.h,
            bottom: 180.h,
            child: Container(
              height: 320.h,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  //to do nikko
                },
                child: Image.asset(
                  AppEraAssets.next,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ),
          ),
        if (showListedby == true)
          Positioned(
            right: 10.w,
            top: 0.h,
            bottom: 180.h,
            child: Container(
              height: 320.h,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  //to do nikko
                },
                child: Image.asset(
                  AppEraAssets.prev,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
