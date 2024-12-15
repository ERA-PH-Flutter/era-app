import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/web/mobile_drawer.dart';
import '../../../../app/widgets/web/navbar.dart';

class HomePages extends GetResponsiveView<HomsController> {
  HomePages({super.key});

  @override
  Widget phone() {
    return Scaffold(
      key: controller.scaffoldKey,
      endDrawer: AppDrawer(),
      body: Stack(children: [
        Obx(() => Container(
            width: Get.width,
            height: Get.height,
            child: controller.pages[selectedIndex.value])),
        Align(
          alignment: Alignment.topCenter,
          child: Navbar(),
        )
      ]),
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
              collapsedHeight: 155.h,
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
                          child: controller.pages[selectedIndex.value],
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

  Widget _buildFooter() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Card(
          color: AppColors.white,
          elevation: 7,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 3),
            width: Get.width,
            height: Get.height / 2.8,
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
          height: 80.h,
          child: Center(
            child: EraText(
              text: '© 2024 ERA Real Estate Philipines. All rights reserved.',
              color: AppColors.blue2,
              fontSize: EraTheme.paragraphWeb - 15.sp,
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
        sb30(),
        EraText(
          text: 'LISTINGS',
          color: AppColors.blue2,
          fontSize: EraTheme.subHeaderWeb - 5.sp,
          fontWeight: FontWeight.bold,
        ),
        sb10(),
        EraText(
          text: 'Pre-Launched Projects',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Residential',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Commercial',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Rental',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Auction',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
      ],
    );
  }

  Widget _columnNews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sb30(),
        EraText(
          text: 'NEWS',
          color: AppColors.blue2,
          fontSize: EraTheme.subHeaderWeb - 5.sp,
          fontWeight: FontWeight.bold,
        ),
        sb10(),
        EraText(
          text: 'ERA GLOBAL',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'ERA Asia Pacific',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'ERA Singapore',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'We Are ERA',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Press Room',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Careers',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Privacy Policy',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Security Policy',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
      ],
    );
  }

  Widget _columnAboutUs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sb30(),
        EraText(
          text: 'ABOUT US',
          color: AppColors.blue2,
          fontSize: EraTheme.subHeaderWeb - 5.sp,
          fontWeight: FontWeight.bold,
        ),
        sb10(),
        EraText(
          text: 'Join As Agent',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Why Us?',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'ERA Teach Tools',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Ultimate Agent',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Training',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Our Services',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
        EraText(
          text: 'Contact Us',
          color: AppColors.blue2,
          fontSize: EraTheme.paragraphWeb - 10.sp,
        ),
      ],
    );
  }

  Widget _columnERAph() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sb30(),
        EraText(
          text: 'ERA PHILLIPINES',
          color: AppColors.blue2,
          fontSize: EraTheme.subHeaderWeb - 5.sp,
          fontWeight: FontWeight.bold,
        ),
        sb10(),
        Row(
          children: [
            Row(
              children: [
                Container(
                  color: AppColors.hint.withOpacity(0.1),
                  child: Image.asset(
                    fit: BoxFit.cover,
                    AppEraAssets.eraPh,
                    height: 150.h,
                    width: 150.w,
                  ),
                )
              ],
            ),
            sbw10(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: 'Address',
                  color: AppColors.blue2,
                  fontSize: EraTheme.paragraphWeb - 10.sp,
                ),
                EraText(
                  text: 'ERA APAC Centre 3000',
                  color: AppColors.blue2,
                  fontSize: EraTheme.paragraphWeb - 10.sp,
                ),
                EraText(
                  text: 'Somewhere in the Philippines',
                  fontSize: EraTheme.paragraphWeb - 10.sp,
                  color: AppColors.blue2,
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(controller.whatsappUrl);
                  },
                  child: EraText(
                    text: 'Phone: +639177710572',
                    fontSize: EraTheme.paragraphWeb - 10.sp,
                    color: AppColors.blue2,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(controller.emailUrl);
                  },
                  child: EraText(
                    text: 'Email: sales@eraphilippines.com',
                    fontSize: EraTheme.paragraphWeb - 10.sp,
                    color: AppColors.blue2,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
