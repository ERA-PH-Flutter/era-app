import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../presentation/website/news/controllers/news_controller.dart';
import 'navbar.dart';

class CompanyNewsPageWeb extends GetView<NewsWebController> {
  // final String? title;
  // final String? image;
  // final String? description;

  CompanyNewsPageWeb({
    super.key,
    // this.title,
    // this.image,
    // this.description,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(NewsWebController());
    return 
        // appBar: NavbarWeb(
        //   webcontroller: controller,
        //   shortestSide: shortestSide,
        //   navItemSelected: (index) {
        //     controller.pageController.jumpToPage(index);
        //     Get.back();
        //   },
        // ),
        Padding(
      padding: EdgeInsets.all(EraTheme.paddingWidthAdmin + 10.w),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: newsArgument['title'] ?? "",
                  color: AppColors.kRedColor,
                  fontSize: EraTheme.headerWeb,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10.h),
                CloudStorage().imageLoader(
                  reference: newsArgument['image'],
                  height: Get.height,
                  width: Get.width,
                ),
                SizedBox(height: 20.h),
                EraText(
                  text: newsArgument['description']!,
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
        ],
      ),
    );
  }
}
