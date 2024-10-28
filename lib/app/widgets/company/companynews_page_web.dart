import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyNewsPageWeb extends StatelessWidget {
  final String? title;
  final String? image;
  final String? description;

  CompanyNewsPageWeb({
    super.key,
    this.title,
    this.image,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(EraTheme.paddingWidthAdmin + 10.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: title!,
              color: AppColors.kRedColor,
              fontSize: EraTheme.headerWeb,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 10.h),
            CloudStorage().imageLoader(
              ref: image,
              height: Get.height,
              width: Get.width,
            ),
            SizedBox(height: 20.h),
            EraText(
              text: description!,
              color: AppColors.black.withOpacity(0.8),
              fontSize: EraTheme.paragraphWeb,
              textAlign: TextAlign.start,
              maxLines: 100,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
