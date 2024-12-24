import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../presentation/global.dart';

import '../../../presentation/website/authentication.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/theme.dart';
import '../app_text.dart';

class Navbar extends GetResponsiveView<HomsController> {
  Navbar()
      : super(
          settings: ResponsiveScreenSettings(
            desktopChangePoint: 1000,
            tabletChangePoint: 768,
            watchChangePoint: 300,
          ),
        );

  @override
  Widget desktop() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      height: 120.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed('/home'),
            child: Image.asset(
              AppEraAssets.eraPh,
              height: 250.h,
            ),
          ),
          Spacer(),
          ..._buildNavItems(controller.items),
          Spacer(),
          //   _showOverlayProfile()
          user == null
              ? ElevatedButton(
            onPressed: () => showAuthenticationDialog(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kRedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 24.w, vertical: 24.h),
            ),
            child: EraText(
              text: "AGENT/BROKER LOGIN",
              fontSize: EraTheme.h6,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          )
              : _showOverlayProfile(),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems(List<String> items) {
    return items.map((item) {
      final isActive =
          Get.currentRoute == "/${item.toLowerCase().replaceAll(" ", "-")}";
      return InkWell(
        onTap: () {
          // controller.navBarSelectedIndex.value = items.indexOf(item);
          // controller.onNavbarItemSelected(items.indexOf(item));
          Get.toNamed("/${item.toLowerCase().replaceAll(" ", "-")}");
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EraText(
                text: item,
                color: isActive ? AppColors.kRedColor : Colors.black,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: EraTheme.h6,
              ),
              if (isActive)
                Container(
                  margin: EdgeInsets.only(top: 4.h),
                  height: 2,
                  width: 24.w,
                  color: AppColors.kRedColor,
                ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _AgentProfile() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: CloudStorage().imageLoaderProvider(
            reference: user!.image!,
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: -5,
          right: -5,
          child: Container(
            height: 36.h,
            width: 36.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_drop_down,
              color: Colors.black87,
              size: 24.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _showOverlayProfile() {
    return GestureDetector(
      onTap: () {
        controller.overlayPortal.isShowing
            ? controller.overlayPortal.show()
            : controller.overlayPortal.hide();
      },
      child: OverlayPortal(
        controller: controller.overlayPortal,
        overlayChildBuilder: (BuildContext context) {
          return Positioned(
            top: 120,
            right: 20,
            child: Card(
              elevation: 8,
              // borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: 300.w,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildMenuWidget(
                      icon: Icons.person,
                      label: user!.firstname!,
                      onTap: () {
                        // selectedIndex.value = 11;
                        // Get.find<HomsController>().onNavbarItemSelected(11);
                        controller.overlayPortal = OverlayPortalController();
                        Get.toNamed('/agent-dashboard');
                      },
                    ),
                    sb10(),
                    Divider(thickness: 1, height: 1, color: Colors.grey[300]),
                    sb10(),
                    buildMenuWidget(
                        icon: Icons.settings,
                        label: "Settings",
                        onTap: () {
                          // selectedIndex.value = 20;
                          // Get.find<HomsController>().onNavbarItemSelected(20);
                          controller.overlayPortal = OverlayPortalController();
                          Get.toNamed('/settings');
                        }),
                    sb10(),
                    Divider(thickness: 1, height: 1, color: Colors.grey[300]),
                    sb10(),
                    buildMenuWidget(
                      icon: Icons.logout,
                      label: "Log-out",
                      onTap: ()async{
                        await Authentication().logout();
                        controller.overlayPortal = OverlayPortalController();
                        Get.deleteAll();
                        Get.toNamed('/home');
                   //     controller.
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: GestureDetector(
          onTap: () {
            controller.overlayPortal.toggle();
          },
          child: _AgentProfile(),
        ),
      ),
    );
  }
}

Widget agentProfile() {
  return CloudStorage().imageLoaderProvider(
    reference: user!.image,
    width: 100.h,
    height: 100.h,
    shadow: [
      BoxShadow(
          spreadRadius: 2,
          blurRadius: 10,
          color: Colors.black.withOpacity(0.2),
          offset: Offset(1, 1))
    ],
  );
}

Widget buildMenuWidget(
    {IconData? icon, String? label, void Function()? onTap}) {
  return ListTile(
    leading: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      height: 48.h,
      width: 48.w,
      child: Icon(icon, color: AppColors.kRedColor, size: 24.sp),
    ),
    title: EraText(
      text: label!,
      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
    ),
    onTap: onTap,
    hoverColor: AppColors.kRedColor.withOpacity(0.1),
    // trailing: Icon(Icons.arrow_forward_ios),
  );
}
