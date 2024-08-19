import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyItems extends StatelessWidget {
  final companyItems;
  const CompanyItems({super.key, required this.companyItems});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: companyItems.image,
              fit: BoxFit.cover,
              height: 250.h,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
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
              padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthSmall,vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EraText(
                    text: companyItems.title,
                    fontSize: EraTheme.paragraph + 4.sp,
                    color: AppColors.kRedColor,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: companyItems.description,
                    fontSize: EraTheme.paragraph,
                    color: Colors.black,
                    maxLines: 4,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Button(
                    text: 'READ MORE',
                    onTap: () {
                      Get.toNamed("/aboutus");
                    },
                    bgColor: AppColors.kRedColor,
                    height: 40.h,
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
      ],
    );
  }
}
