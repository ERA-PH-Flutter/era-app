import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/navbaritems.dart';
import 'package:eraphilippines/app/widgets/app_nav_items.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// RxInt activeIndex = 0.obs;

//not sure how to pass this widget in other folder i can only access this thru the home folder
class CustomNavigationBar extends StatelessWidget {
  final List<AppPngAssets> navBarItems;
  final HomeController controller;
  const CustomNavigationBar(
      {super.key, required this.navBarItems, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CurvedNavigationBar(
        height: 70.h,
        color: AppColors.blue,
        backgroundColor: Colors.white.withOpacity(0),
        buttonBackgroundColor: Colors.white.withOpacity(0),
        index: controller.selectedIndex.value,
        onTap: controller.changeIndex,
        items: navBarItems.map((item) {
          int currentIndex = navBarItems.indexOf(item);
          String iconPath = controller.selectedIndex.value == currentIndex
              ? item.selectedIcon
              : item.defaultIcon;

          return AppNavItems(
              onTap: () {
                controller.changeIndex(currentIndex);
                // activeIndex.value = currentIndex;
                item.onTap?.call();
              },
              iconPath: iconPath,
              label: item.label,
              isActive: controller.selectedIndex.value == currentIndex);
        }).toList(),
      );
    });
  }
}
