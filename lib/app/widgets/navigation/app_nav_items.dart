import 'package:eraphilippines/app/services/ai_search.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
        onTap: index != null
            ? () async {
                if (index == 1) {
                  selectedIndex.value = 0;
                  pageViewController.animateToPage(0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                  currentRoute = '/home';
                } else if (index == 2) {
                  selectedIndex.value = 1;
                  currentRoute = '/project-main';
                  pageViewController.animateToPage(1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                } else if (index == 3) {
                  selectedIndex.value = 2;
                  currentRoute = '/searchresult';
                  pageViewController.animateToPage(2,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                } else if (index == 4) {
                  selectedIndex.value = 3;
                  currentRoute = '/findagents';
                  pageViewController.animateToPage(3,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                } else if (index == 5) {
                  selectedIndex.value = 4;
                  currentRoute = '/help';
                  pageViewController.animateToPage(4,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                }
              }
            : null,
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
              SizedBox(
                height: 7.5.h,
              )
            ],
          ),
        ),
      );
    }
  }
}
