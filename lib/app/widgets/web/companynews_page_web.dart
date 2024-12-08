import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/presentation/website/form/pages/about_us_web.dart';

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
    return Column(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sb40(),
                EraText(
                  text: newsArgument['title'] ?? "",
                  color: AppColors.kRedColor,
                  fontSize: EraTheme.subHeaderWeb,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
                sb50(),
                CloudStorage().imageLoader(
                  reference: newsArgument['image'],
                  fit: BoxFit.contain,
                ),
                sb50(),
                EraText(
                  text: newsArgument['description']!,
                  color: AppColors.black.withOpacity(0.8),
                  fontSize: EraTheme.paragraphWeb - 10.sp,
                  textAlign: TextAlign.start,
                  maxLines: 100,
                  fontWeight: FontWeight.w400,
                ),
                sb80(),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
          child: AboutUsWeb.joinUs(),
        ),
        sb50(),
      ],
    );
  }
}
