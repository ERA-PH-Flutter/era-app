import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/web/navbar.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/screens.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/web/companynews_page_web.dart';
import '../../form/controllers/form_web_controller.dart';
import '../../form/pages/about_us_web.dart';
import '../controllers/news_controller.dart';

class CompanyNewsWeb extends GetView<NewsWebController> {
  const CompanyNewsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(NewsWebController());
    // HomsController homsController = Get.put(HomsController());

    return SingleChildScrollView(
      child: SafeArea(
        child: Obx(() => switch (controller.newsState.value) {
          NewsState.loading => _loading(),
          NewsState.loaded => _loaded(),
        }),
      ),
    );
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Navbar(),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
          child: EraText(
            text: 'LATEST NEWS AND EVENTS',
            color: AppColors.blue,
            fontSize: EraTheme.headerWeb.sp + 5.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.right,
          ),
        ),
        sb20(),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
          width: Get.width,
          height: Get.height,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.news.length,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () {
                // Get.to(() => CompanyNewsPageWeb(
                //     title: controller.news[i].title,
                //     image: controller.news[i].image,
                //     description: controller.news[i].description));
                HomsController homsController = Get.find<HomsController>();
                selectedIndex.value = 10;
                homsController.onNavbarItemSelected(10);
                newsArgument = {
                  "title": controller.news[i].title,
                  "image": controller.news[i].image,
                  "description": controller.news[i].description
                };
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
                          text: controller.news[i].title.toUpperCase(),
                          fontSize: EraTheme.headerWeb - 5.sp,
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
                          reference: controller.news[i].image,
                          height: Get.height / 2,
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
        // AboutUsWeb.bottomWidget(controller: formWebController),
      ],
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: Saf
 
