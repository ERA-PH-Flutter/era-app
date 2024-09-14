import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/company/companynews_page.dart';
import 'package:eraphilippines/presentation/admin/news/controller/new_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/app_text.dart';

class ViewAllNews extends GetView<NewsController> {
  const ViewAllNews({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController controller = Get.put(NewsController());
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EraText(
                        text: 'Company News',
                        fontSize: EraTheme.header + 5.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kRedColor),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/companynews");
                      },
                      child: EraText(
                          text: 'See all',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                EraText(
                  text:
                      'Stay updated with ERA Philippines\' latest services and innovations in real estate excellence',
                  fontSize: EraTheme.subHeader - 2.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.hint,
                ),
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  height: 550.h,
                  width: Get.width,
                  child: GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisExtent: 390.w, //410
                    ),
                    itemCount: controller.news.length,
                    itemBuilder: (context, i) => GestureDetector(
                      onTap: () {
                        Get.offAll(() => CompanyNewsPage(
                            title: controller.news[i].title,
                            image: controller.news[i].image,
                            description: controller.news[i].description));
                      },
                      child: Container(
                        width: Get.width,
                        margin: EdgeInsets.only(bottom: 15.h, right: 12.w),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CloudStorage().imageLoader(
                                  ref: controller.news[i].image,
                                  height: 250.h,
                                ),
                                Spacer(),
                              ],
                            ),
                            Positioned(
                              bottom: 15.h,
                              left: -4.w,
                              right: -4.w,
                              top: 200.h,
                              child: Card(
                                color: AppColors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          EraTheme.paddingWidthSmall + 15.w,
                                      vertical: 15.h),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      EraText(
                                        text: controller.news[i].title,
                                        fontSize: EraTheme.paragraph + 5.sp,
                                        color: AppColors.kRedColor,
                                        fontWeight: FontWeight.bold,
                                        textOverflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                      EraText(
                                        text: controller.news[i].description,
                                        fontSize: EraTheme.paragraph - 2.sp,
                                        color: AppColors.hint,
                                        fontWeight: FontWeight.w500,
                                        maxLines: 5,
                                        textOverflow: TextOverflow.ellipsis,
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
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
