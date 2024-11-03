import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/web/navbar.dart';

class HomePages extends GetResponsiveView<HomsController> {
  @override
  Widget phone() {
    Get.put(HomsController());
    return Scaffold(
      key: controller.scaffoldKey,
      body: Stack(
        children: [
          Obx(() => Container(
                width: Get.width,
                height: Get.height,
                child: controller.pages[controller.selectedIndex.value],
              )),
          Align(
            alignment: Alignment.topCenter,
            child: Navbar(),
          ),
          //footer
        ],
      ),
    );
  }

  @override
  Widget desktop() {
    Get.put(HomsController());
    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          Obx(
            () => SliverAppBar(
              automaticallyImplyLeading: false,
              collapsedHeight: 150.h,
              backgroundColor: AppColors.white,
              floating: false,
              pinned: controller.isNavbarVisible.value,
              flexibleSpace: FlexibleSpaceBar(
                title: Navbar(),
                background: Container(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Obx(
                        () => SizedBox(
                          width: Get.width,
                          child:
                              controller.pages[controller.selectedIndex.value],
                        ),
                      ),
                      _buildFooter(),
                    ],
                  ),
                ],
              );
            },
            childCount: 1,
          ))
        ],
      ),
    );
  }
  //@override
  // Widget desktop() {
  //   Get.put(HomsController());
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Stack(
  //         children: [
  //           Column(
  //             children: [
  //               Align(
  //                 alignment: Alignment.topCenter,
  //                 child: Navbar(),
  //               ),
  //               Obx(
  //                 () => SizedBox(
  //                   width: Get.width,
  //                   child: controller.pages[controller.selectedIndex.value],
  //                 ),
  //               ),
  //               _buildFooter(),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildFooter() {
    return Column(
      children: [
        Card(
          color: AppColors.white,
          elevation: 7,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 3),
            width: Get.width,
            height: Get.height / 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _columnListing(),
                _columnNews(),
                _columnAboutUs(),
                _columnERAph(),
              ],
            ),
          ),
        ),
        Container(
          width: Get.width,
          height: 100.h,
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              '© 2024 ERA Real Estate Philipines. All rights reserved.',
              style: TextStyle(color: AppColors.blue2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _columnListing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'LISTINGS',
          color: AppColors.blue2,
          fontSize: EraTheme.subHeaderWeb,
          fontWeight: FontWeight.bold,
        ),
        sb20(),
        EraText(
          text: 'Pre-Launched Projects',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'Residential',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'Commercial',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'Rental',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'Auction',
          color: AppColors.blue2,
        ),
      ],
    );
  }

  Widget _columnNews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'NEWS',
          color: AppColors.blue2,
          fontSize: EraTheme.subHeaderWeb,
          fontWeight: FontWeight.bold,
        ),
        sb20(),
        EraText(
          text: 'ERA GLOBAL',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'ERA Asia Pacific',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'ERA Singapore',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'We Are ERA',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'Press Room',
          color: AppColors.blue2,
        ),
        EraText(
          text: 'Careers',
          color: AppColors.blue2,
        ),
        EraText(
          text: 'Privacy Policy',
          color: AppColors.blue2,
        ),
        EraText(
          text: 'Security Policy',
          color: AppColors.blue2,
        ),
      ],
    );
  }

  Widget _columnAboutUs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'ABOUT US',
          color: AppColors.blue2,
          fontSize: EraTheme.subHeaderWeb,
          fontWeight: FontWeight.bold,
        ),
        sb20(),
        EraText(
          text: 'Join As Agent',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'Why Us?',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'ERA Teach Tools',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'Ultimate Agent',
          color: AppColors.blue2,
        ),
        sb10(),
        EraText(
          text: 'Training',
          color: AppColors.blue2,
        ),
        EraText(
          text: 'Our Services',
          color: AppColors.blue2,
        ),
        EraText(
          text: 'Contact Us',
          color: AppColors.blue2,
        ),
      ],
    );
  }

  Widget _columnERAph() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'ERA PHILLIPINES',
          color: AppColors.blue2,
          fontSize: EraTheme.subHeaderWeb,
          fontWeight: FontWeight.bold,
        ),
        sb20(),
        Row(
          children: [
            Row(
              children: [
                Image.asset(
                  AppEraAssets.eraPh,
                  height: 150.h,
                  width: 150.w,
                )
              ],
            ),
            sb10(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: 'Address',
                  color: AppColors.blue2,
                ),
                sb10(),
                EraText(
                  text: 'ERA APAC Centre 3000',
                  color: AppColors.blue2,
                ),
                sb10(),
                EraText(
                  text: 'Somewhere in the Philippines',
                  color: AppColors.blue2,
                ),
                sb30(),
                EraText(
                  text: 'Phone: +63 123 456 7890',
                  color: AppColors.blue2,
                ),
                EraText(
                  text: 'Email: ear@era.com.ph',
                  color: AppColors.blue2,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
