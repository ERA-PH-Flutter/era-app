import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MenuItem {
  const MenuItem({
    required this.text,
  });

  final String text;
}

abstract class MenuItems {

 
  static const List<MenuItem> firstItems = [
    findproperties,
    projects,
    agents,
    aboutus
  ];
  static const List<MenuItem> secondItems = [login];

  static const findproperties = MenuItem(
    text: 'FIND PROPERTIES',
  );
  static const projects = MenuItem(
    text: 'PROJECTS',
  );
  static const agents = MenuItem(
    text: 'FIND AGENTS',
  );
  static const aboutus = MenuItem(
    text: 'ABOUT US',
  );
  static const login = MenuItem(
    text: 'LOGIN',
  );
  // static const login = MenuItem(
  //   text: 'LOGOUT',
  // );
 
  static Widget buildItem(MenuItem item) {
    return Card(
      color: AppColors.white,
      elevation: 4,
      child: SizedBox(
        width: 180.w,
        height: 45.h,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: EraText(
                  text: item.text,
                  color: AppColors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //   ),
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.findproperties:
        Get.toNamed("/findproperties");
        break;

      case MenuItems.projects:
        Get.toNamed("/project");
        break;
      case MenuItems.agents:
        Get.toNamed("/findagents");

        break;
      case MenuItems.login:
        Get.toNamed("/loginpage");

        break;
      // case MenuItems.logout:
      // Get.toNamed("/loginpage");
      // break;
      case MenuItems.aboutus:
        Get.toNamed("/aboutus");
        break;
    }
  }
}
