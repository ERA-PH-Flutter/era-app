import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar_admin.dart';
import 'package:eraphilippines/presentation/admin/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/add-agent.dart';
import 'package:eraphilippines/presentation/admin/agentssssssaw/controllers/agents-admin_controller.dart';
import 'package:eraphilippines/presentation/admin/agentssssssaw/pages/add-agent_admin.dart';
import 'package:eraphilippines/presentation/admin/dashboard/customer_reviews/pages/customer_reviews.dart';
import 'package:eraphilippines/presentation/admin/dashboard/home_analytics/pages/home_analytics.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:eraphilippines/presentation/admin/listings/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/admin/listings/pages/add-property_admin.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//todo: nikko, i want you to check my code if it is correct, so later on you wont have a hard time to fix it.

List<Widget> _screens = [
  //change this to add agents
  GetBuilder<AgentAdminController>(
    init: AgentAdminController(),
    builder: (controller) => AgentAdmin(),
  ),
  // roster
  GetBuilder<AgentsAdminController>(
    init: AgentsAdminController(),
    builder: (controller) => AddAgents(),
  ),
  //agent profile
  HomeAnalytics(),
  //property list
  CustomerReviews(),
  //add listings
  GetBuilder<ListingsAdminController>(
    init: ListingsAdminController(),
    builder: (controller) => AddPropertyAdmin(),
  ),
];

class LandingPage extends GetView<LandingPageController> {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 130.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200.w,
              height: 200.h,
              color: AppColors.blue,
              child: Image.asset(
                AppEraAssets.eraPhLogo,
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
                        AppEraAssets.notifAdmin,
                        height: 50.h,
                      ),
                      Image.asset(
                        AppEraAssets.helpAdmin,
                        height: 50.h,
                      ),
                      Image.asset(
                        AppEraAssets.mailAdmin,
                        height: 50.h,
                      ),
                      Image.asset(
                        AppEraAssets.profileAdmin,
                        height: 80.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            EraText(
                              text: 'FirstName LastName',
                              color: AppColors.white,
                              fontSize: 12.sp,
                            ),
                            EraText(
                              text: 'Status',
                              color: AppColors.white,
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 30.h,
                    width: Get.width,
                    color: Colors.grey[350],
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 5.w,
                      ),
                      child: EraText(
                        text: ' Dashboard',
                        color: AppColors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
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
          width: 200.w,
          color: AppColors.hint.withOpacity(0.3),
          child: _buildSidebarMenu(),
        ),
        Expanded(child: _screens[controller.selectedIndex.value]),
      ],
    );
  }

  _error() {
    //todo add error screen
    return Container(
      child: EraText(
        text: 'errorrrr',
        color: AppColors.black,
      ),
    );
  }

  _empty() {
    return Container(
      child: EraText(
        text: 'errorrrr',
        color: AppColors.black,
      ),
    );
    //todo add empty screen
  }

  Widget _buildSidebarMenu() {
    return ListView(
      children: [
        // _buildExpansionTile(
        //   text: "DASHBOARD",
        //   image: AppEraAssets.dashboard,
        //   children: [
        //     _buildMenuItem('Home Analytics', 0),
        //     _buildMenuItem('Reviews Customer', 1),
        //   ],
        // ),
        _buildExpansionTile(
          text: "AGENTS",
          image: AppEraAssets.agentDash,
          children: [
            _buildMenuItem('ADD AGENT', 0),
            _buildMenuItem('ROSTER', 1),
            _buildMenuItem('AGENT PROFILE', 2),
          ],
        ),
        _buildExpansionTile(
          text: "LISTINGS",
          image: AppEraAssets.listingDash,
          children: [
            _buildMenuItem('PROPERTY LIST', 3),
            _buildMenuItem('ADD PROPERTY', 4),
            _buildMenuItem('EDIT PROPERTY', 5),
            _buildMenuItem('PROPERTY DETAILS', 6),
            Divider(
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: AppColors.blue,
            ),
            _buildMenuItem('PROJECT LIST', 7),
            _buildMenuItem('ADD PROJECT', 8),
            _buildMenuItem('EDIT PROJECT', 9),
            _buildMenuItem('PROJECT DETAILS', 10),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItem(String title, int pageIndex) {
    return Obx(() {
      bool isSelected = controller.selectedIndex.value == pageIndex;
      return Ink(
        child: ListTile(
          title: Center(
            child: EraText(
              text: title,
              lineHeight: 0.2.h,
              fontSize: 12.sp,
              color: isSelected ? AppColors.kRedColor : AppColors.black,
            ),
          ),
          onTap: () {
            controller.onItemTapped(pageIndex);
          },
        ),
      );
    });
  }

  Widget _buildExpansionTile({
    required String text,
    required String image,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      leading: const SizedBox(),
      title: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Image.asset(
            image,
            height: 80.h,
          ),
          SizedBox(
            height: 5.h,
          ),
          EraText(
            text: text,
            fontSize: 12.sp,
            color: AppColors.blue,
            fontWeight: FontWeight.w700,
          )
        ],
      ),
      trailing: const SizedBox(),
      children: children,
    );
  }
}
