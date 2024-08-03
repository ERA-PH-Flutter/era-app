import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/authentication/controllers/authentication_binding.dart';
import 'package:eraphilippines/presentation/authentication/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

 
  static List<MenuItem> firstItems = [
    findproperties,
    projects,
    agents,
    aboutus
  ];
  static List secondItems = [login.obs];

  static var findproperties = MenuItem(
    text: 'FIND PROPERTIES',
  );
  static var projects = MenuItem(
    text: 'PROJECTS',
  );
  static var agents = MenuItem(
    text: 'FIND AGENTS',
  );
  static var aboutus = MenuItem(
    text: 'ABOUT US',
  );
  static var login = MenuItem(
    text: FirebaseAuth.instance.currentUser == null ? "LOGIN" : "LOGOUT",
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
    if(item == MenuItems.findproperties){
      Get.toNamed("/findproperties");
    }else if(item == MenuItems.projects){
      Get.toNamed("/project");
    }else if(item == MenuItems.agents){
      Get.toNamed("/findagents");
    }else if(item == MenuItems.login){
      if(FirebaseAuth.instance.currentUser == null){
        Get.toNamed("/loginpage");
      }else{
        Authentication().logout();
        Get.to(LoginPage(),binding: LoginPageBinding());
      }

    }else if(item == MenuItems.aboutus){
      Get.toNamed("/aboutus");
    }
  }
}
