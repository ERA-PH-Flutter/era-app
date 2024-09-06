import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../custom_appbar.dart';

class CompanyNewsPage extends StatelessWidget {
  String? title;
  String? image;
  String? description;
  CompanyNewsPage({
    super.key,
    this.title,
    this.image,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Padding(
        padding: EdgeInsets.all(EraTheme.paddingWidth),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: title!,
                color: AppColors.kRedColor,
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10.h),
              CloudStorage().imageLoader(
                ref: image!,
                height: 250.h,
                width: Get.width,
              ),
              SizedBox(height: 20.h),
              EraText(
                text: description!,
                color: AppColors.black.withOpacity(0.8),
                fontSize: 18.sp,
                textAlign: TextAlign.start,
                maxLines: 100,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
