import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar_admin.dart';
import 'package:eraphilippines/presentation/admin/dashboard/customer_reviews/pages/customer_reviews.dart';
import 'package:eraphilippines/presentation/admin/dashboard/home_analytics/pages/home_analytics.dart';

import 'package:eraphilippines/presentation/admin/landingpage/admin-home/controllers/landingpage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

List<Widget> _screens = [
  HomeAnalytics(),
  CustomerReviews(),

  // AllAgents(),
  // AddAgent(),
  // AllListings(),
  // AddListing(),
  // Settings(),
  // Messaging(),
];

var _selectedIndex = 0.obs;

void _onItemTapped(int index) {
  _selectedIndex.value = index;
}

class LandingPage extends GetView<LandingPageController> {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 160.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 75.w,
              color: AppColors.blue,
              child: Image.asset(
                AppEraAssets.emailIcon,
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        AppEraAssets.emailIcon,
                        height: 50.h,
                      ),
                      Image.asset(
                        AppEraAssets.help1,
                        height: 50.h,
                      ),
                      Image.asset(
                        AppEraAssets.mailAdmin,
                        height: 60.h,
                      ),
                      Image.asset(
                        AppEraAssets.profileAdmin,
                        height: 80.h,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EraText(
                              text: 'FirstName LastName',
                              color: AppColors.white,
                              fontSize: 5.sp,
                            ),
                            EraText(
                              text: 'Status',
                              color: AppColors.white,
                              fontSize: 5.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 60.h,
                    width: Get.width,
                    color: AppColors.hint,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, bottom: 10.h),
                      child: EraText(
                        text: ' Dashboard',
                        color: AppColors.black,
                        fontSize: 8.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.landingState.value) {
                LandingState.loading => _loading(),
                LandingState.loaded => _loaded(),
                LandingState.error => _error(),
                LandingState.empty => _empty()
              }),
        ),
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  _loaded() {
    //

    return Row(
      children: [
        Container(
          width: 75.w,
          color: Colors.grey[200],
          child: _buildSidebarMenu(),
        ),
        Expanded(child: _screens[_selectedIndex.value]),
      ],
    );
  }

  _error() {
    //todo add error screen
  }
  _empty() {
    //todo add empty screen
  }

  Widget _buildSidebarMenu() {
    return ListView(
      children: [
        _buildExpansionTile(
          image: AppEraAssets.dashboard,
          text: "dashboard",
          icon: Icons.dashboard,
          children: [
            _buildMenuItem('Home Analytics', () {
              // Navigate to home
              Get.toNamed('/home-analytics');
            }),
            _buildMenuItem('Reviews Customer', () {
              // Navigate to analytics
              Get.toNamed('/analytics');
            }),
          ],
        ),
        _buildExpansionTile(
          image: AppEraAssets.dashboard,
          text: "dashboard",
          icon: Icons.people,
          children: [
            _buildMenuItem('All Agents', () {
              // Navigate to all agents
              Get.toNamed('/agents/all');
            }),
            _buildMenuItem('Add Agent', () {
              // Navigate to add agent
              Get.toNamed('/agents/add');
            }),
          ],
        ),
        _buildExpansionTile(
          image: AppEraAssets.dashboard,
          text: "dashboard",
          icon: Icons.home,
          children: [
            _buildMenuItem('All Listings', () {
              // Navigate to all listings
              Get.toNamed("/addlistings-admin");
            }),
            _buildMenuItem('Add Listing', () {
              // Navigate to add listing
              Get.toNamed('/listings/add');
            }),
          ],
        ),
        _buildMenuItem('Settings', () {
          // Navigate to settings
          Get.toNamed('/settings');
        }),
        _buildMenuItem('Messaging', () {
          // Navigate to messaging
          Get.toNamed('/messaging');
        }),
      ],
    );
  }

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return Obx(
      () => Ink(
        color: controller.selected.value ? AppColors.blue : null,
        child: ListTile(
          title: Column(
            children: [
              Center(
                  child: EraText(
                text: title,
                lineHeight: 0.2.h,
                fontSize: 5.sp,
                color: AppColors.black,
              )),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

Widget _buildExpansionTile({
  required String image,
  required String text,
  required IconData icon,
  required List<Widget> children,
}) {
  return ExpansionTile(
    leading: const SizedBox(),
    title: Column(
      children: [
        Image.asset(
          image,
          height: 100.h,
          width: 100.w,
        ),
        EraText(
          text: text,
          fontSize: 7.sp,
          color: AppColors.black,
        )
      ],
    ),
    trailing: const SizedBox(),
    children: children,
  );
}
