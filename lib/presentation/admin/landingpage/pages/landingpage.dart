import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar_admin.dart';
import 'package:eraphilippines/presentation/admin/Listings/pages/add_listing_admin.dart';
import 'package:eraphilippines/presentation/admin/Listings/pages/edit_listing_admin.dart';
import 'package:eraphilippines/presentation/admin/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/add-agent.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/agent_profile_admin.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/approvedagents.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/roster.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:eraphilippines/presentation/admin/listings/pages/add_project_admin.dart';
import 'package:eraphilippines/presentation/admin/listings/pages/propertylist_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LandingPage extends GetView<LandingPageController> {
    LandingPage({super.key});

  final List<Widget> _screens =   [
    ApprovedAgents(),
    PropertylistAdmin(),
    AddProjectAdmin(),
    AddAgent(),
    Roster(),
    AgentProfileAdmin(),
    AddAgent(),
    AddPropertyAdmin(),
    EditPropertyAdmin(),
    AddAgent(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(AgentAdminController());

    return Scaffold(
        backgroundColor: AppColors.white,
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
        ));
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
                  fontSize: 12.sp),
              EraText(text: 'Status', color: AppColors.white, fontSize: 12.sp),
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
            text: ' Dashboard',
            color: AppColors.black,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  Widget _buildSidebarMenu() => ListView(
        children: [
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
                  color: AppColors.blue),
              _buildMenuItem('PROJECT LIST', 7),
              _buildMenuItem('ADD PROJECT', 8),
              _buildMenuItem('EDIT PROJECT', 9),
              _buildMenuItem('PROJECT DETAILS', 10),
            ],
          ),
        ],
      );

  Widget _buildMenuItem(String title, int pageIndex) => Obx(() {
        final bool isSelected = controller.selectedIndex.value == pageIndex;
        return ListTile(
          title: Center(
            child: EraText(
              text: title,
              lineHeight: 0.2.h,
              fontSize: 12.sp,
              color: isSelected ? AppColors.kRedColor : AppColors.black,
            ),
          ),
          onTap: () => controller.onItemTapped(pageIndex),
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
          EraText(
              textOverflow: TextOverflow.ellipsis,
              text: text,
              fontSize: 12.sp,
              maxLines: 1,
              color: AppColors.blue,
              fontWeight: FontWeight.w700),
        ],
      ),
      trailing: const SizedBox(),
      children: children,
    );
  }
}
