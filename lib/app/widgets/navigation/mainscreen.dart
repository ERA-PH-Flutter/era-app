import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/navbaritems.dart';
import 'package:eraphilippines/app/widgets/navigation/app_nav_items.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/findagents.dart';
import 'package:eraphilippines/presentation/agent/home/pages/home.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/projectmain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../presentation/agent/forms/contacts/pages/help.dart';
import '../../../presentation/agent/listings/searchresult/pages/searchresult.dart';
import '../custom_appbar.dart';

var selectedIndex = 0.obs;

class MainScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              selectedIndex.value = index;
            },
            children: [
              Scaffold(body: Home()),
              Scaffold(body: ProjectMain()),
              Scaffold(body: SearchResult()),
              Scaffold(body: FindAgents()),
              Scaffold(body: Help()),
            ],
          ),
          Obx(
            () => CurvedNavigationBar(
              height: 70.h < 75 ? 70.h : 75,
              color: AppColors.blue,
              backgroundColor: Colors.white.withOpacity(0),
              buttonBackgroundColor: Colors.white.withOpacity(0),
              index: selectedIndex.value,
              onTap: (index) {
                pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              items: navBarItems.map((item) {
                int currentIndex = navBarItems.indexOf(item);
                String iconPath = selectedIndex.value == currentIndex
                    ? item.selectedIcon
                    : item.defaultIcon;

                return AppNavItems(
                  onTap: () {
                    pageController.animateToPage(
                      currentIndex,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  iconPath: iconPath,
                  label: item.label,
                  isActive: selectedIndex.value == currentIndex,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
