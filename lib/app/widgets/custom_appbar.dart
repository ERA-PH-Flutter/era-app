import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/inbox_widget.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_binding.dart';
import 'package:eraphilippines/presentation/agent/home/controllers/home_binding.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_binding.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../presentation/agent/authentication/controllers/authentication_binding.dart';
import '../../presentation/agent/authentication/pages/login_page.dart';
import '../services/firebase_auth.dart';
import 'navigation/customenavigationbar.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({
    super.key,
    this.leading,
    this.action,
    this.height = 85,
  });
  final Widget? leading;
  final Widget? action;
  final double height;
  var doLogout = false.obs;
  var controller = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  [
                            '/haraya',
                            '/aurelia',
                            '/laya',
                            '/agentMyListing',
                            '/AgentListings',
                            '/propertyInfo',
                            '/editListings',
                            '/addListings',
                            '/fav',
                            '/soldP',
                            '/archived',
                          ].contains(Get.currentRoute) &&
                          (Platform.isIOS)
                      ? IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_ios, size: 20.sp))
                      : Visibility(visible: false, child: Container()),
                  leading ??
                      Transform.translate(
                          offset: Offset(-14, 1),
                          child: IconButton(
                            icon: Image.asset(
                              'assets/images/eraph_logo.png',
                            ),
                            onPressed: () {
                              selectedIndex.value = 0;
                              currentRoute = '/home';
                              Get.offAll(BaseScaffold(),binding: HomeBinding());
                            },
                          )),
                ],
              ),
              Row(
                children: [
                  action ??
                      (user != null
                          ? StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('messages')
                                  .where("to", whereIn: ["all"]).snapshots(),
                              builder: (context, snapshot) {
                                int count = 0;
                                if (snapshot.hasData) {
                                  if (snapshot.data != null) {
                                    count = snapshot.data!.docs.length;
                                  } else {
                                    count = 0;
                                  }
                                }
                                return SizedBox(
                                  width: 55.w,
                                  height: 48.w,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(() => InboxScreen(),
                                                binding: LoginPageBinding());
                                          },
                                          child: Icon(CupertinoIcons.mail,
                                              color: AppColors.hint,
                                              size: 30.sp),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3.w)),
                                          width: 25.w,
                                          height: 25.w,
                                          child: EraText(
                                            text: count.toString(),
                                            fontSize: 10.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          : Container()),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      controller.isShowing
                          ? controller.hide()
                          : controller.show();
                    },
                    child: OverlayPortal(
                      controller: controller,
                      overlayChildBuilder: (BuildContext context) {
                        return Positioned(
                          top: 120,
                          right: 0,
                          child: Wrap(
                            children: [
                              Container(
                                width: 240.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.r),
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                child: Column(
                                  children: [
                                    user != null
                                        ? _buildMenuCard('MY DASHBOARD', () {
                                      currentRoute = '/agentDashBoard';
                                      Get.offAllNamed("/agentDashBoard");
                                    },
                                        Get.currentRoute ==
                                            '/agentDashBoard')
                                        : Container(),
                                    _buildMenuCard('FIND PROPERTIES', () {
                                      currentRoute = '/findproperties';
                                      Get.offAllNamed("/findproperties");
                                    }, Get.currentRoute == '/findproperties'),
                                    _buildMenuCard('PROJECTS', () {
                                      selectedIndex.value = 1;
                                      pageViewController = PageController(initialPage: 1);
                                      currentRoute = '/project-main';
                                      Get.offAll(BaseScaffold(),binding: ProjectsBinding());
                                    }, currentRoute == '/project-main' || Get.currentRoute == '/project-main'),
                                    _buildMenuCard('FIND AGENTS', () {
                                      selectedIndex.value = 3;
                                      pageViewController = PageController(initialPage: 3);
                                      currentRoute = '/findagents';
                                      Get.offAll(BaseScaffold(),binding: AgentsBinding());
                                    }, Get.currentRoute == '/findagents' || currentRoute == '/findagents'),
                                    _buildMenuCard('ABOUT US', () {
                                      currentRoute = '/aboutus';
                                      Get.offAllNamed("/aboutus");
                                    }, Get.currentRoute == '/aboutus'),
                                    _buildMenuCard('JOIN ERA', () {
                                      currentRoute = '/joinEra';
                                      Get.offAllNamed("/joinEra");
                                    }, Get.currentRoute == '/joinEra'),
                                    _buildMenuCard('SELL PROPERTY', () {
                                      currentRoute = '/sellProperty';
                                      Get.offAllNamed("/sellProperty");
                                    }, Get.currentRoute == '/sellProperty'),
                                    _buildMenuCard('CONTACT US', () {
                                      currentRoute = '/direct-contactus';
                                      Get.offAllNamed("/direct-contactus");
                                    }, Get.currentRoute == '/direct-contactus'),
                                    _buildMenuCard('MORTGAGE CALCULATOR', () {
                                      currentRoute = '/mortageCalculator';
                                      Get.offAllNamed("/mortageCalculator");
                                    },
                                        Get.currentRoute ==
                                            '/mortageCalculator'),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    Obx(() {
                                      doLogout.value;
                                      return _buildMenuCard(
                                          user == null ? "LOGIN" : "LOGOUT",
                                          () async {
                                        if (user == null) {
                                          selectedIndex.value = 0;
                                          Get.toNamed("/loginpage");
                                        } else {
                                          BaseController().showLoading();
                                          doLogout.value = true;
                                          user = null;
                                          await Authentication().logout();
                                          Get.to(LoginPage(),
                                              binding: LoginPageBinding());
                                        }
                                      }, Get.currentRoute == '/loginpage');
                                    })
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Image.asset(
                        AppEraAssets.menubar,
                        height: 65,
                        width: 65,
                      ),
                    ),
                  )
                  // Obx((){
                  //   return
                  //   // return DropdownButtonHideUnderline(
                  //   //     child: DropdownButton2(
                  //   //       customButton: Image.asset(
                  //   //         AppEraAssets.menubar,
                  //   //         height: 65,
                  //   //         width: 65,
                  //   //       ),
                  //   //       items: [
                  //   //         ...MenuItems.firstItems.map(
                  //   //               (item) => DropdownMenuItem<MenuItem>(
                  //   //             value: item,
                  //   //             child: MenuItems.buildItem(item),
                  //   //           ),
                  //   //         ),
                  //   //         const DropdownMenuItem<Divider>(
                  //   //             enabled: false,
                  //   //             child: Divider(
                  //   //               thickness: 2,
                  //   //               color: Colors.grey,
                  //   //             )),
                  //   //         ...MenuItems.secondItems.map(
                  //   //               (item) => DropdownMenuItem(
                  //   //             value: item.value,
                  //   //             child: MenuItems.buildItem(item.value),
                  //   //           ),
                  //   //         ),
                  //   //       ],
                  //   //       onChanged: (value) {
                  //   //         MenuItems.onChanged(context, value! as MenuItem);
                  //   //       },
                  //   //       buttonStyleData: ButtonStyleData(
                  //   //         height: 50.h,
                  //   //         elevation: 2,
                  //   //         decoration: BoxDecoration(
                  //   //           borderRadius: BorderRadius.circular(14),
                  //   //           color: Colors.transparent,
                  //   //         ),
                  //   //       ),
                  //   //       dropdownStyleData: DropdownStyleData(
                  //   //         width: 250.w,
                  //   //         decoration: BoxDecoration(
                  //   //           borderRadius: BorderRadius.circular(14),
                  //   //           color: Colors.white.withOpacity(0.8),
                  //   //         ),
                  //   //       ),
                  //   //       menuItemStyleData: MenuItemStyleData(
                  //   //         customHeights: [
                  //   //           ...List<double>.filled(
                  //   //             MenuItems.firstItems.length,
                  //   //             50,
                  //   //           ),
                  //   //           10,
                  //   //           ...List<double>.filled(
                  //   //               MenuItems.secondItems.length, 50),
                  //   //         ],
                  //   //         // padding: const EdgeInsets.only(left: 30, right: 30),
                  //   //       ),
                  //   //     ));
                  // })
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 85,
            child: Divider(
              thickness: 1,
              color: AppColors.hint.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  _buildMenuCard(text, callback, isActive) {
    return GestureDetector(
      onTap: callback,
      child: Card(
        color: isActive ? AppColors.kRedColor : AppColors.white,
        elevation: 4,
        child: SizedBox(
          // width: Get.width,
          height: 45.h,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 200.w,
                    child: EraText(
                      textOverflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      text: text,
                      color: isActive ? AppColors.white : AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
