import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/navbaritems.dart';
import 'package:eraphilippines/app/widgets/navigation/app_nav_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var selectedIndex = 0.obs;

void changeIndex(int index) {
  navBarItems[index].onTap?.call();
  selectedIndex.value = index;

  Widget nextPage;
  switch (index) {
    case 0:
      nextPage = HomePage();

      break;
    case 1:
      Get.toNamed('/project-main');
      break;
    case 2:
      Get.toNamed('/searchresult');
      break;
    case 3:
      Get.toNamed('/findagents');
      break;
    case 4:
      Get.toNamed('/help');
      break;
  }

  // Get.off(
  //   () => nextPage,
  //   transition: Transition.noTransition,
  //   routeSettings: RouteSettings(name: '/'),
  //   duration: Duration(milliseconds: 500),
  //   popGesture: true,
  //   fullscreenDialog: false,
  // );
}

class BaseScaffold extends StatelessWidget {
  final Widget body;

  const BaseScaffold({
    super.key,
    required this.body,
  });
  @override
  Widget build(BuildContext context) {
    //changeIndex(['/home','/project-main', '/searchresult','/findagents','/help'].contains(Get.currentRoute) ? ['/home','/project-main','/searchresult','/findagents','/help'].indexOf(Get.currentRoute) : 0);
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppbar(),
        body: body,
        bottomNavigationBar: CurvedNavigationBar(
          height: 70.h < 75 ? 70.h : 75,
          color: AppColors.blue,
          backgroundColor: Colors.white.withOpacity(0),
          buttonBackgroundColor: Colors.white.withOpacity(0),

          // buttonBackgroundColor: AppColors.maroon,
          index: [
            '/home',
            '/project-main',
            '/searchresult',
            '/findagents',
            '/help'
          ].contains(Get.currentRoute)
              ? [
                  '/home',
                  '/project-main',
                  '/searchresult',
                  '/findagents',
                  '/help'
                ].indexOf(Get.currentRoute)
              : 0,
          onTap: (index) {
            changeIndex(index);
            navBarItems[index].onTap?.call();
          },
          items: navBarItems.map((item) {
            int currentIndex = navBarItems.indexOf(item);
            String iconPath = selectedIndex.value == currentIndex
                ? item.selectedIcon
                : item.defaultIcon;

            return AppNavItems(
                onTap: () {
                  changeIndex(currentIndex);
                  item.onTap?.call();
                },
                iconPath: iconPath,
                label: item.label,
                isActive: selectedIndex.value == currentIndex);
          }).toList(),
        ));
  }
}
