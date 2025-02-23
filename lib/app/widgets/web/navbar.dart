import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../presentation/global.dart';

import '../../../presentation/website/authentication/pages/login_web.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/theme.dart';
import '../app_text.dart';

class Navbar extends GetResponsiveView<HomsController> {
  Navbar({super.key})
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
          // _showOverlayProfile()
          user == null
              ? ElevatedButton(
                  onPressed: () => showAuthenticationDialog(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kRedColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
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

  @override
  Widget phone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.toNamed('/home'),
            child: Image.asset(
              AppEraAssets.eraPh,
              height: 40.h, // Smaller logo for mobile
            ),
          ),
          IconButton(
            icon: Icon(Icons.menu, size: 32.sp, color: AppColors.kRedColor),
            onPressed: () => _showMobileMenu(), // Function to open menu
          ),
        ],
      ),
    );
  }

  void _showMobileMenu() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            String item = controller.items[index];
            bool? isSelected;
            Map<String, String> routeMapping = {
              "HOME": "/home",
              "PROJECTS": "/projects",
              "SEARCH": "/search",
              "FIND AGENTS": "/find-agents",
              "HELP": "/help",
              "JOIN US": "/join-us",
              "SELL PROPERTY": "/sell-property",
              "MORTGAGE CALCULATOR": "/mortgage-calculator",
            };
            return ListTile(
              // tileColor: controller.isSelected.value == item
              //     ? AppColors.kRedColor
              //     : null,
              title: EraText(text: item, color: Colors.black),
              onTap: () {
                //   controller.isSelected.value = item;
                Get.back();
                Future.delayed(Duration(milliseconds: 300), () {
                  String? route = routeMapping[item];
                  if (route != null) {
                    print("navigate to: $route");
                    Get.toNamed(route);
                  } else {
                    print("route not found: $item");
                  }
                });
              },
            );
          },
        ),
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

  Widget _showOverlayProfile() {
    return Column(
      children: [
        PopupMenuButton<String>(
          tooltip: "",
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          splashRadius: 24,
          offset: const Offset(0, 100),
          color: Colors.white,
          onSelected: (String value) {
            switch (value) {
              case 'dashboard':
                controller.selectedOption(value);
                Get.toNamed('/agent-dashboard');
                break;
              case 'settings':
                controller.selectedOption(value);
                Get.toNamed('/settings');
                break;
              case 'logout':
                Authentication().logout();
                Get.deleteAll();
                Get.toNamed('/home');
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'dashboard',
                child: buildMenuWidget(
                  icon: Icons.person,
                  label: user!.firstname!,
                ),

                //  EraText(text: user!.firstname!),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: buildMenuWidget(
                  icon: Icons.settings,
                  label: "Settings",
                ),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: buildMenuWidget(
                  icon: Icons.logout,
                  label: "Log-out",
                ),
              ),
            ];
          },
          child: agentProfile(),
        ),
      ],
    );
  }
}

Widget agentProfile() {
  return Container(
    child: CloudStorage().imageLoaderProvider(
      reference: user!.image,
      width: 120.h,
      height: 120.h,
      shadow: [
        BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: Colors.black.withOpacity(0.2),
            offset: Offset(1, 1))
      ],
    ),
  );
}

Widget buildMenuWidget({IconData? icon, String? label}) {
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
      height: 38.h,
      width: 38.w,
      child: Icon(icon, color: AppColors.kRedColor, size: 24.sp),
    ),
    title: Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: EraText(
        text: label!,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    hoverColor: AppColors.kRedColor.withOpacity(0.1),
  );
}
