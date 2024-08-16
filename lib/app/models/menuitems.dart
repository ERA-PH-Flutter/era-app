import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../presentation/agent/utility/controller/base_controller.dart';
import '../../presentation/agent/authentication/controllers/authentication_binding.dart';
import '../../presentation/agent/authentication/pages/login_page.dart';

// TO DO: NIKKO -  
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
    aboutus,
    mydashboard,
    mortCalcu,
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

  static var login;
  //will only show when log in
  static var mydashboard = MenuItem(
    text: 'MY DASHBOARD',
  );
  //will only show when its not log in
   static var sellProperty = MenuItem(
    text: 'SELL PROPERTY',
  );
  static var mortCalcu = MenuItem(
    text: 'MORTGAGE CALCULATOR',
  );
 

  static Widget buildItem(MenuItem item) {
   login = FirebaseAuth.instance.currentUser == null ? MenuItem(
     text: "LOGIN",
    ): MenuItem(
     text: "LOGOUT",
    );
    return Card(
      color: AppColors.white,
      elevation: 4,
      child: SizedBox(
        // width: Get.width,
        height: 45.h,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: EraText(
                  text: item.text,
                  color: AppColors.black,
                  fontSize: 14.sp,
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
    if (item == MenuItems.findproperties) {
      Get.toNamed("/findproperties");
    } else if (item == MenuItems.projects) {
      Get.toNamed("/project");
    } else if (item == MenuItems.agents) {
      Get.toNamed("/findagents");
    } else if (item == MenuItems.mydashboard) {
      if (RealEstateListing.listingsModels.isNotEmpty) {
        Get.toNamed("/agentDashBoard",
            arguments: RealEstateListing.listingsModels.first);
      } else {
        BaseController().showSuccessDialog(
            title: "Error!", description: "No Profile found");
      }
    } else if (item == MenuItems.mortCalcu) {
      Get.toNamed("/mortageCalculator");
    } else if (item == MenuItems.login) {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.toNamed("/loginpage");
      } else {
        Authentication().logout();
        Get.to(LoginPage(), binding: LoginPageBinding());
      }
    } else if (item == MenuItems.aboutus) {
      Get.toNamed("/aboutus");
    }
  }
}
