import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar_admin.dart';
import 'package:eraphilippines/presentation/admin/setting/contact_us/pages/contact_us_admin.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/about_us.dart';
import 'package:eraphilippines/presentation/admin/faqs/pages/general_faq.dart';
import 'package:eraphilippines/presentation/admin/news/pages/upload_news.dart';
import 'package:eraphilippines/presentation/admin/news/pages/view_all_news.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/homepage.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/listing_admin_controller.dart';
import 'package:eraphilippines/presentation/admin/properties/pages/add_listing_admin.dart';
import 'package:eraphilippines/presentation/admin/properties/pages/add_project_admin.dart';
import 'package:eraphilippines/presentation/admin/properties/pages/edit_listing_admin.dart';
import 'package:eraphilippines/presentation/admin/properties/pages/propertyinformation.dart';
import 'package:eraphilippines/presentation/admin/properties/pages/propertylisting_admin.dart';
import 'package:eraphilippines/presentation/admin/setting/log_list/pages/log_list_admin.dart';
import 'package:eraphilippines/presentation/admin/properties/pages/view_project.dart';
import 'package:eraphilippines/presentation/admin/setting/sell_property/pages/sell_property_admin.dart';
import 'package:eraphilippines/presentation/admin/trainings/pages/upload_training_admin.dart';
import 'package:eraphilippines/presentation/admin/trainings/pages/view_all_training.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/agent_profile_admin.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/approvedagents.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/roster.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../global.dart';
import '../../content-management/pages/join_era copy.dart';
import '../../content-management/pages/join_era.dart';
import '../../statitics/pages/statistics_admin.dart';

class LandingPage extends GetView<LandingPageController> {
  LandingPage({super.key});

  final List<Widget> _screens = [
    Roster(), //0
    AddAgent(), //1
    ApprovedAgents(), //2
    AgentProfileAdmin(), //3 invisible
    AddProjectAdmin(), //4
    PropertylistAdmin(), //5
    PropertyInformationAdmin(), //6
    AddPropertyAdmin(), //7
    EditPropertyAdmin(), //8
    HomePage(), //9
    AboutUsPage(), //10
    ViewAllNews(), //11
    UploadNews(), //12
    StatisticsAdmin(), //STATISTICS 13
    GeneralFaq(), //14
    SellPropertyAdmin(), //15
    ContactUsAdmin(), //16
    ViewAllTraining(), //17
    UploadTrainingAdmin(), //18
    ViewProject(), //19
    LogListAdmin(), //20
    FindAgentPage(), //21
    JoinEraPage(), //22

    // UploadNews(), //14
    // UploadNews(), //15
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
          width: 210.w,
          color: AppColors.hint.withOpacity(0.3),
          child: _buildSidebarMenu(),
        ),
        Expanded(
          child: _screens[controller.selectedSectionIndex.value],
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
    return EraText(
      text: 'No content available',
      color: AppColors.black,
    );
  }

  Widget _buildAppBarContent() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 210.w,
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
        //Image.asset(AppEraAssets.mailAdmin, height: 50.h),
        Image.asset(AppEraAssets.profileAdmin, height: 80.h),
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  if (user != null) {
                    return EraText(
                      text:
                          '${user!.firstname ?? "Loading"} ${user!.lastname ?? "Name.."}',
                      color: AppColors.white,
                      fontSize: 15.sp,
                    );
                  } else {
                    return EraText(
                      text: 'No Name',
                      color: AppColors.white,
                      fontSize: 15.sp,
                    );
                  }
                },
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            BaseController().showSuccessDialog(
              hitApi: () async {
                await Authentication().logout();
                Get.toNamed(RouteString.adminLogin);
              },
              title: "Logout?",
              description: "Logout your admin account?",
              cancelable: true,
              cancelButton: "Cancel",
            );
          },
          icon: Icon(
            Icons.power_settings_new,
            color: Colors.white,
            size: 30.sp,
          ),
        ),
        SizedBox(
          width: 20.w,
        )
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
              text: "STATISTICS",
              image: AppEraAssets.statistics,
              children: [
                _buildMenuItem('MANAGE STATISTICS', 13),
              ],
              index: 0,
              expandedController: controller.expandedControllers[0]),
          _buildExpansionTile(
              text: "USERS",
              image: AppEraAssets.dashboard,
              children: [
                _buildMenuItem('ROSTER', 0),
                _buildMenuItem('ADD AGENT', 1),
                _buildMenuItem('APPROVAL NEW AGENT', 2),
                //     _buildMenuItem('VIEW AGENTS/BROKERS', 3),
              ],
              index: 1,
              expandedController: controller.expandedControllers[1]),
          _buildExpansionTile(
              text: "PROPERTIES",
              image: AppEraAssets.agentDash,
              children: [
                _buildMenuItem('ADD PROJECTS', 4),
                _buildMenuItem('VIEW PROJECT', 19),

                _buildMenuItem('PROPERTY LISTINGS', 5),
                // _buildMenuItem('PROPERTY INFORMATION', 6),
                _buildMenuItem('ADD LISTINGS', 7),
                //_buildMenuItem('EDIT LISTINGS', 8),
              ],
              index: 2,
              expandedController: controller.expandedControllers[2]),
          _buildExpansionTile(
              text: "CONTENT",
              image: AppEraAssets.listingDash,
              children: [
                _buildMenuItem('HOMEPAGE', 9),
                _buildMenuItem('FIND AGENTS', 21),

                //  _buildMenuItem('ADD ABOUT US', 10),
                _buildMenuItem('JOIN ERA', 22),
              ],
              index: 3,
              expandedController: controller.expandedControllers[3]),
          _buildExpansionTile(
              text: "NEWS",
              image: AppEraAssets.news,
              children: [
                _buildMenuItem('VIEW ALL NEWS', 11),
                _buildMenuItem('ADD NEWS', 12),
              ],
              index: 4,
              expandedController: controller.expandedControllers[4]),
          _buildExpansionTile(
              text: "FAQS",
              image: AppEraAssets.helpDash,
              children: [
                _buildMenuItem('General FAQ’S', 14),
                // _buildMenuItem('Agent FAQ’s', 12),
                // _buildMenuItem('Customer FAQ’s', 13),
              ],
              index: 5,
              expandedController: controller.expandedControllers[5]),
          _buildExpansionTile(
              text: "SETTINGS",
              image: AppEraAssets.settingDash,
              children: [
                _buildMenuItem('SELLING PROPERTY', 15),
                _buildMenuItem('CONTACT US MANAGEMENT', 16),
                _buildMenuItem('ACTIVITY LIST', 20),

                // _buildMenuItem('Agent FAQ’s', 12),
                // _buildMenuItem('Customer FAQ’s', 13),
              ],
              index: 6,
              expandedController: controller.expandedControllers[6]),
          // _buildExpansionTile(
          //   text: "TRAINING",
          //   image: AppEraAssets.trainings,
          //   children: [
          //     _buildMenuItem('VIEW ALL TRAINING UPLOADS', 17),

          //     _buildMenuItem('TRAININGS UPLOAD', 18),
          //     // _buildMenuItem('Agent FAQ’s', 12),
          //     // _buildMenuItem('Customer FAQ’s', 13),
          //   ],
          // ),
        ],
      );

  Widget _buildMenuItem(String title, int section) => Obx(() {
        final bool isSelected =
            controller.selectedSectionIndex.value == section;
        return ListTile(
          title: Container(
            alignment: Alignment.center,
            height: 40.h,
            child: EraText(
              textAlign: TextAlign.center,
              text: title,
              fontSize: 13.sp,
              color: isSelected ? AppColors.kRedColor : AppColors.black,
            ),
          ),
          onTap: () async {
            if (section == 7) {
              Get.put(ListingsController());
            } else if (section == 9) {
              Get.put(ContentManagementController());
            }
            controller.onSectionSelected(section);
          },
        );
      });

  Widget _buildExpansionTile(
      {required String text,
      required String image,
      required List<Widget> children,
      required index,
      required expandedController}) {
    return ExpansionTile(
      onExpansionChanged: ((newState) {
        print(index);
        if (newState) {
          controller.selectedTile = index;
          for (int i = 0; i < controller.expandedControllers.length; i++) {
            if (i != index) {
              if (controller.expandedControllers[i].isExpanded) {
                controller.expandedControllers[i].collapse();
              }
            }
          }
        } else {
          controller.selectedTile = -1;
        }
      }),
      controller: expandedController,
      leading: SizedBox(),
      title: Image.asset(
        image,
        height: 80.h,
        color: AppColors.blue,
      ),
      subtitle: SizedBox(
        height: 40.h,
        width: Get.width,
        child: EraText(
            textAlign: TextAlign.center,
            text: text,
            fontSize: 12.sp,
            maxLines: 1,
            color: AppColors.blue,
            fontWeight: FontWeight.w700),
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

