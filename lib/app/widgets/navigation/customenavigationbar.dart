import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/navbaritems.dart';
import 'package:eraphilippines/app/widgets/navigation/app_nav_items.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;

  const BaseScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: body,
      bottomNavigationBar: Obx(() {
        return CurvedNavigationBar(
          height: 70.h,
          color: AppColors.blue,
          backgroundColor: Colors.white.withOpacity(0),
          buttonBackgroundColor: Colors.white.withOpacity(0),
          index: controller.selectedIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
            navBarItems[index].onTap?.call();
          },
          items: navBarItems.map((item) {
            int currentIndex = navBarItems.indexOf(item);
            String iconPath = controller.selectedIndex.value == currentIndex
                ? item.selectedIcon
                : item.defaultIcon;

            return AppNavItems(
                onTap: () {
                  controller.changeIndex(currentIndex);
                  item.onTap?.call();
                },
                iconPath: iconPath,
                label: item.label,
                isActive: controller.selectedIndex.value == currentIndex);
          }).toList(),
        );
      }),
    );
  }
}
