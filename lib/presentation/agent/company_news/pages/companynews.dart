import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/company/companynews_page.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/custom_appbar.dart';
import '../controllers/companynews_controller.dart';

class CompanyNews extends GetView<CompanyNewsController> {
  const CompanyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      //todo for later
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Obx(() => switch (controller.companyNewsState.value) {
                CompanyNewsState.loading => _loading(),
                CompanyNewsState.loaded => _loaded(),
              }),
        ),
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _loaded() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            EraText(
              text: 'Latest News',
              color: AppColors.blue,
              fontSize: EraTheme.header.sp + 5.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 20.h,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.news.length,
              itemBuilder: (context, i) => GestureDetector(
                onTap: () {
                  Get.to(() => CompanyNewsPage(
                      title: controller.news[i].title,
                      image: controller.news[i].image,
                      description: controller.news[i].description));
                },
                child: Container(
                  height: 600.h,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          CloudStorage().imageLoader(
                            ref: controller.news[i].image,
                            height: 250.h,
                            width: Get.width,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 70.h,
                        left: -4.w,
                        right: -4.w,
                        top: 200.h,
                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: EraTheme.paddingWidthSmall + 15.w,
                                vertical: 15.h),
                            child: Column(
                              children: [
                                EraText(
                                  text: controller.news[i].title,
                                  fontSize: EraTheme.paragraph + 5.sp,
                                  color: AppColors.kRedColor,
                                  fontWeight: FontWeight.bold,
                                  textOverflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                                SizedBox(
                                  height: 35.h,
                                ),
                                EraText(
                                  text: controller.news[i].description,
                                  fontSize: EraTheme.paragraph - 2.sp,
                                  color: AppColors.hint,
                                  fontWeight: FontWeight.w500,
                                  maxLines: 5,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: Saf
 
