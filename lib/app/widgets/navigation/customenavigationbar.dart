import 'dart:io';

import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/homepage.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/project_list_controller.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agent_listings_controller.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/findagents.dart';
import 'package:eraphilippines/presentation/agent/home/controllers/home_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_binding.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/pages/searchresult.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/projectmain.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/projects_list.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/navbaritems.dart';
import 'package:eraphilippines/app/widgets/navigation/app_nav_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../presentation/agent/forms/contacts/pages/help.dart';
import '../../../presentation/agent/home/controllers/home_binding.dart';
import '../../../presentation/agent/home/pages/home.dart';
import '../../../presentation/agent/projects/controllers/projects_controller.dart';
import '../../../presentation/global.dart';
import '../../../router/route.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

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

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({
    super.key,
  });

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  @override
  void initState() {
    Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //changeIndex(['/home','/project-main', '/searchresult','/findagents','/help'].contains(Get.currentRoute) ? ['/home','/project-main','/searchresult','/findagents','/help'].indexOf(Get.currentRoute) : 0);
    return Scaffold(
        extendBody: true,
        backgroundColor: AppColors.white,
        appBar: CustomAppbar(),
        body: WillPopScope(
          onWillPop: () async {
            BaseController().showSuccessDialog(
                title: "Confirm Exit",
                description: "Do you wanna exit ERA Philippines App?",
                cancelable: true,
                hitApi: () {
                  Platform.isAndroid ? SystemNavigator.pop() : exit(0);
                });
            return Future.value(true);
          },
          child: PageView(
            controller: pageViewController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Home(),
              ProjectsList(),
              SearchResult(),
              FindAgents(),
              Help(),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() => CircleNavBar(
              tabCurve: Curves.linear,
              tabDurationMillSec: 300,
              onTap: (index) {
                selectedIndex.value = index;
                if (index == 0) {
                  currentRoute = '/home';
                  Get.deleteAll();
                  Get.put(HomeController());
                } else if (index == 1) {
                  //currentRoute = '/project-main';
                  currentRoute = '/project-list';
                  Get.deleteAll();
                  Get.put(ProjectsListController());
                } else if (index == 2) {
                  currentRoute = '/searchresult';
                  Get.deleteAll();
                  SearchResultBinding().dependencies();
                } else if (index == 3) {
                  currentRoute = '/findagents';
                  Get.deleteAll();
                  Get.put(AgentsController());
                } else if (index == 4) {
                  currentRoute = '/about';
                }
                pageViewController.animateToPage(index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              activeIndex: selectedIndex.value,
              height: 75.h,
              activeIcons: navBarItems.map((item) {
                return Image.asset(
                  item.selectedIcon,
                  width: 55.w,
                  height: 55.h,
                );
              }).toList(),
              inactiveIcons: navBarItems.map((item) {
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        item.defaultIcon,
                        width: 40.w,
                        height: 40.h,
                      ),
                      Text(
                        item.label,
                        style: TextStyle(
                            fontSize: 10.sp, color: CupertinoColors.white),
                      ),
                    ],
                  ),
                );
              }).toList(),
              color: AppColors.blue,
            )));
    // bottomNavigationBar:Obx(()=> CurvedNavigationBar(
    //   animationCurve: Curves.linear ,
    //   height: 70.h < 75 ? 70.h : 75,
    //   color: AppColors.blue,
    //   backgroundColor: Colors.white.withOpacity(0),
    //   buttonBackgroundColor: Colors.white.withOpacity(0),
    //
    //   // buttonBackgroundColor: AppColors.maroon,
    //   index: selectedIndex.value,
    //   onTap: (index) {
    //     selectedIndex.value = index;
    //     if(index == 0){
    //       currentRoute = '/home';
    //       Get.deleteAll();
    //       Get.put(HomeController());
    //     }else if(index == 1){
    //       currentRoute = '/project-main';
    //       Get.deleteAll();
    //       Get.put(ProjectsController());
    //     }else if(index == 2){
    //       currentRoute = '/searchresult';
    //       Get.deleteAll();
    //       SearchResultBinding().dependencies();
    //     }else if(index == 3){
    //       currentRoute = '/findagents';
    //       Get.deleteAll();
    //       Get.put(AgentsController());
    //     }else if(index == 4){
    //       currentRoute = '/about';
    //     }
    //     pageViewController.animateToPage(
    //         index,
    //         duration: Duration(milliseconds: 500),
    //         curve: Curves.easeInOut
    //     );
    //   },
    //   items: navBarItems.map((item) {
    //     int currentIndex = navBarItems.indexOf(item);
    //     String iconPath = selectedIndex.value == currentIndex
    //         ? item.selectedIcon
    //         : item.defaultIcon;
    //
    //     return AppNavItems(
    //
    //         iconPath: iconPath,
    //         label: item.label,
    //         isActive: selectedIndex.value == currentIndex);
    //   }).toList(),
    // )));
  }
}
