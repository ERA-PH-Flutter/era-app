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
import '../../../presentation/website/news/controllers/news_webpage_controller.dart';
import '../../constants/screens.dart';

class CompanyNewsPageWeb extends GetView<NewsWebPageController> {
  const CompanyNewsPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => switch (controller.newsState.value) {
          NewsState.loading => _loading(),
          NewsState.loaded => _loaded(),
        });
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sb40(),
              EraText(
                text: controller.newsArgument['title'] ?? "No Title",
                color: AppColors.kRedColor,
                fontSize: EraTheme.subHeaderWeb + 4,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
              ),
              sb30(),
              _buildImageSection(),
              sb40(),
              _buildDescriptionSection(),
              sb50(),
              // _buildFooterSection(),

              ///  _buildGridView(),
              sb50(),
              AboutUsWeb.buildJoinUsSection(),

              //                     child: Row(
              //                       mainAxisAlignment: MainAxisAlignment.end,
              //                       children: [
              //                         EraText(
              //                           text: 'READ MORE',
              //                           fontSize: EraTheme.h5,
              //                           color: AppColors.blue,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                         sbw10(),
              //                         Icon(
              //                           Icons.arrow_forward_ios,
              //                           color: AppColors.blue,
              //                           size: EraTheme.h6,
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 20.h,
              //       ),
              //       sb50(),
              //       AboutUsWeb.buildJoinUsSection(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return ClipRRect(
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
          reference: controller.newsArgument['image'],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return EraText(
      text: controller.newsArgument?['description'] ?? "",
      color: AppColors.black.withOpacity(0.8),
      fontSize: EraTheme.h6,
      textAlign: TextAlign.start,
      maxLines: 100,
      fontWeight: FontWeight.w400,
    );
  }

  Widget _buildFooterSection() {
    return EraText(
      text:
          'Stay updated with ERA Philippines\' latest services and innovations in real estate excellence',
      fontSize: EraTheme.paragraphWeb,
      fontWeight: FontWeight.w500,
      color: AppColors.hint,
    );
  }

  Widget _buildGridView() {
    return SizedBox(
      height: 300.h,
      width: Get.width,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: controller.news.length,
        itemBuilder: (context, i) => GestureDetector(
          onTap: () {
            Get.toNamed('/view-news/${controller.news[i].id}');
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: _buildGridTile(i),
          ),
        ),
      ),
    );
  }

  Widget _buildGridTile(int index) {
    final newsItem = controller.news[index];
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CloudStorage().imageLoader(
            reference: newsItem.image,
            height: 350.h,
            width: Get.width,
            fit: BoxFit.cover,
          ),
        ),
        sb40(),
        EraText(
          text: newsItem.title.toUpperCase(),
          fontSize: EraTheme.h3,
          color: AppColors.kRedColor,
          fontWeight: FontWeight.bold,
          textOverflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        SizedBox(height: 8.h),
        EraText(
          text: newsItem.description,
          fontSize: EraTheme.h6,
          color: AppColors.hint,
          fontWeight: FontWeight.w500,
          maxLines: 3,
          textOverflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 16.h),
        GestureDetector(
          onTap: () {
            Get.toNamed('/view-news/${controller.news[index].id}');
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
