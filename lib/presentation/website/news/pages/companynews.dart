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

import '../controllers/news_controller.dart';

class CompanyNewsWeb extends GetView<NewsWebController> {
  const CompanyNewsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(NewsWebController());
    // HomsController homsController = Get.put(HomsController());

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sb50(),
          EraText(
            text: 'LATEST NEWS AND EVENTS FROM ERA PHILIPPINES',
            color: AppColors.blue,
            fontSize: EraTheme.h1,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.right,
          ),
          Divider(color: AppColors.kRedColor, thickness: 0.5),

          sb50(),
          Container(
            width: Get.width,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => sb40(),
              itemCount: controller.news.length,
              itemBuilder: (context, i) => Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 2))
                    ]),
                child: GestureDetector(
                  onTap: () {
                    // HomsController homsController = Get.find<HomsController>();
                    // selectedIndex.value = 9;
                    // homsController.onNavbarItemSelected(9);
                    // newsArgument = {
                    //   "title": controller.news[i].title,
                    //   "image": controller.news[i].image,
                    //   "description": controller.news[i].description
                    // };
                    Get.toNamed('/view-news/${controller.news[i].id}');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
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
                                fontSize: EraTheme.h3,
                                color: AppColors.kRedColor,
                                fontWeight: FontWeight.bold,
                                textOverflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              sb10(),
                              EraText(
                                text: controller.news[i].description,
                                fontSize: EraTheme.h6,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                                maxLines: 5,
                              ),
                              sb50(),
                            ],
                          ),
                        ),
                        sbw50(),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CloudStorage().imageLoader(
                                    reference: controller.news[i].image,
                                    height: 350.h,
                                    width: Get.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // AboutUsWeb.bottomWidget(controller: formWebController),
        ],
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: Saf
 
