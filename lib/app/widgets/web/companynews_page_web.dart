import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../presentation/global.dart';
import '../../../presentation/website/form/pages/about_us_web.dart';
import '../../../presentation/website/landingpage/controller/homs_controller.dart';
import '../../../presentation/website/news/controllers/news_controller.dart';
import 'navbar.dart';

class CompanyNewsPageWeb extends GetView<NewsWebController> {
  CompanyNewsPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NewsWebController());
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sb40(),

                EraText(
                  text: newsArgument['title'] ?? "Company News",
                  color: AppColors.kRedColor,
                  fontSize: EraTheme.subHeaderWeb + 4,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),

                sb30(),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CloudStorage().imageLoader(
                      reference: newsArgument['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                sb40(),
                EraText(
                  text: newsArgument['description'] ?? "",
                  color: AppColors.black.withOpacity(0.8),
                  fontSize: EraTheme.h6,
                  textAlign: TextAlign.start,
                  maxLines: 100,
                  fontWeight: FontWeight.w400,
                ),
                // Container(
                //   padding: EdgeInsets.all(20.r),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10.r),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.1),
                //         blurRadius: 10,
                //         offset: Offset(0, 4),
                //       ),
                //     ],
                //   ),
                //   child: EraText(
                //     text: newsArgument['description'] ?? "",
                //     color: AppColors.black.withOpacity(0.8),
                //     fontSize: EraTheme.h6,
                //     textAlign: TextAlign.start,
                //     maxLines: 100,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),

                //_buildRelatedArticlesSection(),

                sb50(),
                AboutUsWeb.buildJoinUsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedArticlesSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      EraText(
        text: "Related Articles",
        color: AppColors.kRedColor,
        fontSize: EraTheme.h2,
        fontWeight: FontWeight.bold,
      ),
      sb20(),
      //   SizedBox(
      //     height: 200.h,
      //     child: ListView.builder(
      //       scrollDirection: Axis.horizontal,
      //       itemCount: 5, // Replace with dynamic count
      //       itemBuilder: (context, index) {
      //         return Card(
      //           elevation: 3,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10.r),
      //           ),
      //           margin: EdgeInsets.only(right: 20.r),
      //           child: Container(
      //             width: 300.w,
      //             padding: EdgeInsets.all(10.r),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Expanded(
      //                   child: Image.network(
      //                     'https://via.placeholder.com/300', // Placeholder
      //                     fit: BoxFit.cover,
      //                     width: double.infinity,
      //                   ),
      //                 ),
      //                 sb10(),
      //                 EraText(
      //                   text: "Article Title",
      //                   color: AppColors.black,
      //                   fontSize: EraTheme.paragraphWeb - 5.sp,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //                 sb5(),
      //                 EraText(
      //                   text: "Brief description of the article...",
      //                   color: AppColors.hint,
      //                   fontSize: EraTheme.paragraphWeb - 10.sp,
      //                   maxLines: 2,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   ),
      // ],
      SizedBox(
        width: Get.width,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemCount: controller.news.length,
          itemBuilder: (context, i) => GestureDetector(
            onTap: () {
              HomsController homsController = Get.find<HomsController>();
              selectedIndex.value = 9;
              homsController.onNavbarItemSelected(9);
              newsArgument = {
                "title": controller.news[i].title,
                "image": controller.news[i].image,
                "description": controller.news[i].description,
              };
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CloudStorage().imageLoader(
                      reference: controller.news[i].image,
                      height: 350.h,
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  sb40(),
                  EraText(
                    text: controller.news[i].title.toUpperCase(),
                    fontSize: EraTheme.h3,
                    color: AppColors.kRedColor,
                    fontWeight: FontWeight.bold,
                    textOverflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 8.h),
                  EraText(
                    text: controller.news[i].description,
                    fontSize: EraTheme.h6,
                    color: AppColors.hint,
                    fontWeight: FontWeight.w500,
                    maxLines: 3,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      HomsController homsController =
                          Get.find<HomsController>();
                      selectedIndex.value = 11;
                      homsController.onNavbarItemSelected(11);
                      newsArgument = {
                        "title": controller.news[i].title,
                        "image": controller.news[i].image,
                        "description": controller.news[i].description,
                      };
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        EraText(
                          text: 'READ MORE',
                          fontSize: EraTheme.h5,
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        sbw10(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.blue,
                          size: EraTheme.h6,
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
    ]);
  }
}
