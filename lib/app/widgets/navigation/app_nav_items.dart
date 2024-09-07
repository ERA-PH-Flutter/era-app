// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../presentation/agent/agents/controllers/agents_binding.dart';
import '../../../presentation/agent/home/controllers/home_binding.dart';
import '../../../presentation/agent/listings/searchresult/controllers/searchresult_binding.dart';
import '../../../presentation/agent/projects/controllers/projects_binding.dart';
import '../../../presentation/global.dart';
import 'customenavigationbar.dart';

class AppNavItems extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final int? index;
  final Function()? onTap;
  const AppNavItems(
      {super.key,
      required this.iconPath,
      required this.label,
      required this.isActive,
      this.index,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Image.asset(
              iconPath,
              width: 55.w,
              height: 55.h,
            ),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: index != null ? (){
          if(index == 1){
              selectedIndex.value = 0;
              pageViewController = PageController(initialPage: 0);
              currentRoute = '/home';
              Get.offAll(BaseScaffold(),binding: HomeBinding());

          }else if(index == 2){
              selectedIndex.value = 1;
              currentRoute = '/project-main';
              pageViewController = PageController(initialPage: 1);
              Get.offAll(BaseScaffold(),binding: ProjectsBinding());
          }else if(index == 3){
              selectedIndex.value = 2;
              currentRoute = '/searchresult';
              pageViewController = PageController(initialPage: 2);
              Get.offAll(BaseScaffold(),binding: SearchResultBinding());
          }else if(index == 4){
            selectedIndex.value = 3;
            currentRoute = '/findagents';
            pageViewController = PageController(initialPage: 3);
            Get.offAll(BaseScaffold(),binding: AgentsBinding());
          }else if(index == 5){
            selectedIndex.value = 4;
            currentRoute = '/help';
            pageViewController = PageController(initialPage: 4);
            Get.offAll(BaseScaffold());
          }
        } : null,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: 40.w,
                height: 40.h,
              ),
              Text(
                label,
                style: TextStyle(fontSize: 11.sp, color: CupertinoColors.white),
              ),
              SizedBox(height: 7.5.h,)
            ],
          ),
        ),
      );
    }
  }
}
