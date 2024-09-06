import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/homepage.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agent_listings_controller.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/findagents.dart';
import 'package:eraphilippines/presentation/agent/home/controllers/home_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_binding.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/pages/searchresult.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/projectmain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/navbaritems.dart';
import 'package:eraphilippines/app/widgets/navigation/app_nav_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../presentation/agent/forms/contacts/pages/help.dart';
import '../../../presentation/agent/home/controllers/home_binding.dart';
import '../../../presentation/agent/home/pages/home.dart';
import '../../../presentation/global.dart';
import '../../../router/route.dart';

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
        backgroundColor: AppColors.white,
        appBar: CustomAppbar(),
        body: PageView(
          controller: pageViewController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Home(),
            ProjectMain(),
            SearchResult(),
            FindAgents(),
            Help(),
          ],
        ),

        bottomNavigationBar:Obx(()=> CurvedNavigationBar(
          height: 70.h < 75 ? 70.h : 75,
          color: AppColors.blue,
          backgroundColor: Colors.white.withOpacity(0),
          buttonBackgroundColor: Colors.white.withOpacity(0),

          // buttonBackgroundColor: AppColors.maroon,
          index: selectedIndex.value,
          onTap: (index) {
            selectedIndex.value = index;
            if(index == 0){
              currentRoute = '/home';
              Get.deleteAll();
              Get.put(HomeController());
            }else if(index == 1){
              currentRoute = '/project-main';
              Get.deleteAll();
              Get.put(ProjectsController());
            }else if(index == 2){
              currentRoute = '/searchresult';
              Get.deleteAll();
              SearchResultBinding().dependencies();
            }else if(index == 3){
              currentRoute = '/findagents';
              Get.deleteAll();
              Get.put(AgentsController());
            }else if(index == 4){
              currentRoute = '/about';
            }
            pageViewController.animateToPage(
                index,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut
            );
          },
          items: navBarItems.map((item) {
            int currentIndex = navBarItems.indexOf(item);
            String iconPath = selectedIndex.value == currentIndex
                ? item.selectedIcon
                : item.defaultIcon;

            return AppNavItems(

                iconPath: iconPath,
                label: item.label,
                isActive: selectedIndex.value == currentIndex);
          }).toList(),
        )));
  }
}
