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

import '../../../../app/constants/screens.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/custom_appbar.dart';
import '../../form/controllers/form_web_controller.dart';
import '../../form/pages/about_us_web.dart';
import '../controllers/news_controller.dart';

class CompanyNewsWeb extends GetView<NewsController> {
  const CompanyNewsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NewsController());
    return SafeArea(
      child: Obx(() => switch (controller.newsState.value) {
            NewsState.loading => _loading(),
            NewsState.loaded => _loaded(),
          }),
    );
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    FormWebController formWebController = Get.put(FormWebController());

    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(
            horizontal: EraTheme.paddingWidthAdmin + 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
            ),
            EraText(
              text: 'Latest News',
              color: AppColors.blue,
              fontSize: EraTheme.headerWeb.sp + 5.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: Get.width,
              height: Get.height,
              child: ListView.builder(
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
                  // CloudStorage().imageLoader(
                  //           ref: controller.news[i].image,
                  //           height: 250.h,
                  //           width: 200.w,
                  //         ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EraText(
                              text: controller.news[i].title,
                              fontSize: EraTheme.subHeaderWeb - 10.sp,
                              color: AppColors.kRedColor,
                              fontWeight: FontWeight.bold,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                            sb10(),
                            EraText(
                              text: controller.news[i].description,
                              fontSize: EraTheme.paragraphWeb - 5.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                              maxLines: 5,
                            ),
                            sb50(),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            CloudStorage().imageLoader(
                              ref: controller.news[i].image,
                              height: 400.h,
                              width: 400.w,
                              fit: BoxFit.cover,
                            ),
                            sb50(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AboutUsWeb.bottomWidget(controller: formWebController),
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
 
