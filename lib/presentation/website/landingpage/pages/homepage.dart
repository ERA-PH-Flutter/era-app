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
      children: [
        Card(
          color: AppColors.white,
          elevation: 7,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 3, vertical: 20),
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
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
          color: AppColors.blue2,
          child: Center(
            child: EraText(
              text: '© 2024 ERA Real Estate Philippines. All rights reserved.',
              color: AppColors.white,
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
          fontSize: EraTheme.h2,
          fontWeight: FontWeight.bold,
        ),
        sb10(),
        _buildLinkText('Pre-Launched Projects'),
        _buildLinkText('Residential'),
        _buildLinkText('Commercial'),
        _buildLinkText('Rental'),
        _buildLinkText('Auction'),
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
          fontSize: EraTheme.h2,
          fontWeight: FontWeight.bold,
        ),
        sb10(),
        _buildLinkText('ERA GLOBAL'),
        _buildLinkText('ERA Asia Pacific'),
        _buildLinkText('ERA Singapore'),
        _buildLinkText('We Are ERA'),
        _buildLinkText('Press Room'),
        _buildLinkText('Careers'),
        _buildLinkText('Privacy Policy'),
        _buildLinkText('Security Policy'),
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
          fontSize: EraTheme.h2,
          fontWeight: FontWeight.bold,
        ),
        sb10(),
        _buildLinkText('Join As Agent'),
        _buildLinkText('Why Us?'),
        _buildLinkText('ERA Teach Tools'),
        _buildLinkText('Ultimate Agent'),
        _buildLinkText('Training'),
        _buildLinkText('Our Services'),
        _buildLinkText('Contact Us'),
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
          fontSize: EraTheme.h2,
          fontWeight: FontWeight.bold,
        ),
        sb10(),
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
            ),
            sbw10(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLinkText('Address'),
                _buildLinkText('ERA APAC Centre 3000'),
                _buildLinkText('Somewhere in the Philippines'),
                _buildLinkTextWithIcon(
                  'Phone: +639177710572',
                  onTap: () {
                    launchUrl(controller.whatsappUrl);
                  },
                ),
                _buildLinkTextWithIcon('Email: sales@eraphilippines.com',
                    onTap: () {
                  launchUrl(controller.emailUrl);
                }),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLinkText(String text) {
    return EraText(
      text: text,
      color: AppColors.blue2,
      fontSize: EraTheme.bodyText,
    );
  }

  Widget _buildLinkTextWithIcon(String text, {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: EraText(
        text: text,
        fontSize: EraTheme.paragraphWeb - 10.sp,
        color: AppColors.blue2,
      ),
    );
  }
}
