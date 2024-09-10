import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar_admin.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/about_us.dart';
import 'package:eraphilippines/presentation/admin/project_management/pages/add_listing_admin.dart';
import 'package:eraphilippines/presentation/admin/project_management/pages/add_project_admin.dart';
import 'package:eraphilippines/presentation/admin/project_management/pages/edit_listing_admin.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/homepage.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:eraphilippines/presentation/admin/project_management/pages/propertyinformation.dart';
import 'package:eraphilippines/presentation/admin/project_management/pages/propertylisting_admin.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/agent_profile_admin.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/approvedagents.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/roster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LandingPage extends GetView<LandingPageController> {
  LandingPage({super.key});

  final List<Widget> _screens = [
    AddProjectAdmin(),
    AgentProfileAdmin(),
    AddAgent(),
    ApprovedAgents(),
    Roster(),
    PropertylistAdmin(),
    PropertyInformationAdmin(),
    AddPropertyAdmin(),
    EditPropertyAdmin(),
    HomePage(),
    AboutUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(AgentAdminController());
    Get.put(ContentManagementController());
    return Scaffold(
      appBar: CustomAppBar(
        height: 150.h,
        child: _buildAppBarContent(),
      ),
      body: WillPopScope(
        onWillPop: () => _onWillPop(),
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

  Future<bool> _onWillPop() {
    Get.back();
    return Future.value(false);
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  _loaded() {
    return Row(
      children: [
        Container(
          width: 200.w,
          color: AppColors.hint.withOpacity(0.3),
          child: _buildSidebarMenu(),
        ),
        Expanded(
          child: _screens[controller.selectedSectionIndex.value] ?? Container(),
        ),
      ],
    );
  }

  _error() {
    return EraText(
      text: 'errorrrr',
      color: AppColors.black,
    );
  }

  _empty() {
    return Container(
      child: EraText(
        text: 'No content available',
        color: AppColors.black,
      ),
    );
  }

  Widget _buildAppBarContent() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200.w,
            height: 200.h,
            color: AppColors.blue,
            child: Image.asset(AppEraAssets.eraPhLogo),
          ),
          Flexible(
            child: Column(
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: _buildAppBarIcons(),
                ),
                const Spacer(),
                _buildDashboardTitle(),
              ],
            ),
          ),
        ],
      );

  List<Widget> _buildAppBarIcons() => [
        Image.asset(AppEraAssets.notifAdmin, height: 50.h),
        Image.asset(AppEraAssets.helpAdmin, height: 50.h),
        Image.asset(AppEraAssets.mailAdmin, height: 50.h),
        Image.asset(AppEraAssets.profileAdmin, height: 80.h),
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
      ];

  Widget _buildDashboardTitle() => Container(
        height: 45.h,
        width: Get.width,
        color: Colors.grey[350],
        child: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: EraText(
            text: 'Dashboard',
            color: AppColors.black,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  Widget _buildSidebarMenu() => ListView(
        children: [
          _buildExpansionTile(
            text: "USER MANAGEMENT",
            image: AppEraAssets.dashboard,
            children: [
              _buildMenuItem('VIEW AGENTS/BROKERS', 0),
              _buildMenuItem('ADD AGENT', 1),
              _buildMenuItem('APPROVAL NEW AGENT', 2),
              _buildMenuItem('ROSTER', 3),
            ],
          ),
          _buildExpansionTile(
            text: "PROPERTY MANAGEMENT",
            image: AppEraAssets.agentDash,
            children: [
              _buildMenuItem('ADD PROJECTS', 4),
              _buildMenuItem('PROPERTY LISTINGS', 5),
              _buildMenuItem('PROPERTY INFORMATION', 6),
              _buildMenuItem('ADD LISTINGS', 7),
            ],
          ),
          _buildExpansionTile(
            text: "CONTENT MANAGEMENT",
            image: AppEraAssets.listingDash,
            children: [
              _buildMenuItem('HOMEPAGE', 8),
              _buildMenuItem('ABOUT US', 9),
            ],
          ),
        ],
      );

  Widget _buildMenuItem(String title, int section) => Obx(() {
        final bool isSelected =
            controller.selectedSectionIndex.value == section;
        return ListTile(
          title: Container(
            height: 40.h,
            child: EraText(
              textAlign: TextAlign.center,
              text: title,
              fontSize: 12.sp,
              color: isSelected ? AppColors.kRedColor : AppColors.black,
              maxLines: 2,
            ),
          ),
          onTap: () => controller.onSectionSelected(section),
        );
      });

  Widget _buildExpansionTile({
    required String text,
    required String image,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      leading: SizedBox(),
      title: Column(
        children: [
          SizedBox(height: 20.h),
          Image.asset(image, height: 80.h),
          SizedBox(height: 5.h),
          Container(
            height: 40.h,
            child: EraText(
                textAlign: TextAlign.center,
                text: text,
                fontSize: 12.sp,
                maxLines: 2,
                color: AppColors.blue,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
      trailing: const SizedBox(),
      children: children,
    );
  }
}

  // Widget _buildSidebarMenu() => ListView(
  //       children: [
  //         _buildExpansionTile(
  //           text: "USER MANAGEMENT",
  //           image: AppEraAssets.dashboard,
  //           children: [
  //             _buildMenuItem('VIEW AGENTS/BROKERS', 0),

  //             _buildMenuItem('ADD AGENT', 1),
  //             _buildMenuItem('APPROVAL NEW AGENT', 2),
  //             _buildMenuItem('ROSTER', 3),

  //             // _buildMenuItem('HOME', 0),
  //             // _buildMenuItem('PROPERTIES & AGENTS', 1),
  //             // _buildMenuItem('REVIEWS', 2),
  //           ],
  //         ),
  //         _buildExpansionTile(
  //           text: "PROPERTY MANAGEMENT",
  //           image: AppEraAssets.agentDash,
  //           children: [
  //             _buildMenuItem('ADD PROJECTS', 4),
  //             _buildMenuItem('PROPERTY LISTINGS', 5),
  //             _buildMenuItem('ADD LISTINGS', 6),
  //             _buildMenuItem('EDIT LISTINGS', 7),
  //           ],
  //         ),
  //         _buildExpansionTile(
  //           text: "CONTENT MANAGEMENT",
  //           image: AppEraAssets.listingDash,
  //           children: [
  //             _buildMenuItem('HOMEPAGE', 8),
  //             _buildMenuItem('ABOUT US', 9),
  //             // Divider(
  //             //     height: 20,
  //             //     thickness: 1,
  //             //     indent: 20,
  //             //     endIndent: 20,
  //             //     color: AppColors.blue),
  //             // _buildMenuItem('PROJECT LIST', 11),
  //             // _buildMenuItem('ADD PROJECT', 12),
  //             // _buildMenuItem('EDIT PROJECT', 13),
  //             // _buildMenuItem('PROJECT DETAILS', 14),
  //           ],
  //         ),
  //         _buildExpansionTile(
  //           text: "NEWS",
  //           image: AppEraAssets.messagingDash,
  //           children: [
  //             _buildMenuItem('APPROVAL NEW AGENT', 15),
  //             _buildMenuItem('ADD AGENT', 16),
  //             _buildMenuItem('ROSTER', 17),
  //             _buildMenuItem('AGENT PROFILE', 18),
  //           ],
  //         ),
  //         _buildExpansionTile(
  //           text: "HELP",
  //           image: AppEraAssets.settingDash,
  //           children: [
  //             _buildMenuItem('APPROVAL NEW AGENT', 19),
  //             _buildMenuItem('ADD AGENT', 20),
  //             _buildMenuItem('ROSTER', 21),
  //             _buildMenuItem('AGENT PROFILE', 22),
  //           ],
  //         ),
  //         _buildExpansionTile(
  //           text: "MESSAGE/REPORTS",
  //           image: AppEraAssets.settingDash,
  //           children: [
  //             _buildMenuItem('APPROVAL NEW AGENT', 19),
  //             _buildMenuItem('ADD AGENT', 20),
  //             _buildMenuItem('ROSTER', 21),
  //             _buildMenuItem('AGENT PROFILE', 22),
  //           ],
  //         ),
  //         _buildExpansionTile(
  //           text: "ANALYTICS",
  //           image: AppEraAssets.settingDash,
  //           children: [
  //             _buildMenuItem('APPROVAL NEW AGENT', 19),
  //             _buildMenuItem('ADD AGENT', 20),
  //             _buildMenuItem('ROSTER', 21),
  //             _buildMenuItem('AGENT PROFILE', 22),
  //           ],
  //         ),
  //         _buildExpansionTile(
  //           text: "SETTINGS",
  //           image: AppEraAssets.settingDash,
  //           children: [
  //             _buildMenuItem('APPROVAL NEW AGENT', 19),
  //             _buildMenuItem('ADD AGENT', 20),
  //             _buildMenuItem('ROSTER', 21),
  //             _buildMenuItem('AGENT PROFILE', 22),
  //           ],
  //         ),
  //       ],
  //     );

