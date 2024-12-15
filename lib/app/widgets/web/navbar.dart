import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/website/agents/pages/dashboard_web.dart';
import 'package:eraphilippines/presentation/website/authentication/controller/authentication_binding.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:eraphilippines/presentation/website/landingpage/pages/homepage.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import '../../../presentation/global.dart';
import '../../../presentation/website/agents/pages/settingAgent.dart';
import '../../../presentation/website/authentication.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../constants/theme.dart';
import '../app_text.dart';

class Navbar extends GetResponsiveView<HomsController> {
  Navbar()
      : super(
            settings: ResponsiveScreenSettings(
                desktopChangePoint: 1000,
                tabletChangePoint: 768,
                watchChangePoint: 300));

  @override
  Widget phone() {
    Get.put(HomsController());

    return Container(
        width: Get.width,
        height: 56.h,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  print('Menu button clicked!');
                  controller.scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Icon(Icons.menu)),
          ],
        ));
  }

  @override
  Widget desktop() {
    return Obx(
      () => Container(
        // color: AppColors.black,
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth200),
        height: 150.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: AppColors.white,
              child: Image.asset(
                AppEraAssets.eraPh,
                height: Get.height,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildNavItems(controller.items.sublist(0, 5)),
            ),
            //_showOverlay(),
            Spacer(),
            //  if()
            user == null
                ? Builder(
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Button(
                          borderRadius: BorderRadius.circular(20),
                          width: 300.w,
                          onTap: () {
                            showAuthenticationDialog();
                          },
                          text: "AGENT/BROKER LOGIN",
                          bgColor: AppColors.kRedColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  )
                : _showOverlayProfile(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNavItems(List<String> items) {
    List<Widget> navItems = [];

    for (var item in items) {
      navItems.add(InkWell(
        onTap: () {
          if (controller.getBack.value) {
            /// MISSY CHANGE THIS for each index
            Get.offAll(HomePages());
          } else {
            controller.isMoreSelected.value = false;

            controller.navBarSelectedIndex.value =
                controller.items.indexOf(item);
            controller
                .onNavbarItemSelected(controller.navBarSelectedIndex.value);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.w),
              child: EraText(
                text: item,
                color: controller.isMoreSelected.value == true
                    ? Colors.black
                    : controller.navBarSelectedIndex.value ==
                            controller.items.indexOf(item)
                        ? AppColors.kRedColor
                        : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: EraTheme.subHeader,
              ),
            ),
            SizedBox(height: 4),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: 2,
              width: 20,
              color: controller.isMoreSelected.value == true
                  ? Colors.transparent
                  : controller.navBarSelectedIndex.value ==
                          controller.items.indexOf(item)
                      ? AppColors.kRedColor
                      : Colors.transparent,
            ),
          ],
        ),
      ));
      if (item == 'HELP') {
        navItems.add(
          _showOverlay(),
        );
      }
    }
    return navItems;
  }

  Widget _showOverlayProfile() {
    return GestureDetector(
      onTap: () {
        controller.loginOverlay.isShowing
            ? controller.loginOverlay.hide()
            : controller.loginOverlay.show();
      },
      child: CompositedTransformTarget(
        link: controller.link,
        child: OverlayPortal(
          controller: controller.loginOverlay,
          overlayChildBuilder: (BuildContext context) {
            return Positioned(
              top: 120.h,
              left: Get.width / 1.4,
              bottom: 0,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: MenuWidget(
                    width: 300.w,
                    child: ListView(
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectedIndex.value = 13;
                            Get.find<HomsController>().onNavbarItemSelected(13);
                            print('Profile clicked');
                            controller.loginOverlay.hide();
                          },
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.person),
                                sbw10(),
                                EraText(
                                  text: 'Profile',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: EraTheme.subHeader,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.navigate_next),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteString.settingsWeb);
                            controller.loginOverlay.hide();
                          },
                          child: ListTile(
                            title: GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.settings),
                                  sbw10(),
                                  EraText(
                                    text: 'Settings',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: EraTheme.subHeader,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            trailing: Icon(Icons.navigate_next),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Authentication().logout();
                            controller.loginOverlay.hide();
                            Get.deleteAll();
                            Get.toNamed(RouteString.webLandingPage);
                          },
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.logout),
                                sbw10(),
                                EraText(
                                  text: 'Logout',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: EraTheme.subHeader,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.navigate_next),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          },
          child: GestureDetector(
            onTap: () {
              controller.loginOverlay.toggle();
            },
            child: agentProfile(),
          ),
        ),
      ),
    );
  }

  Widget _showOverlay() {
    return GestureDetector(
      onTap: () {
        controller.isMoreSelected.value = !controller.isMoreSelected.value;
        if (controller.isMoreSelected.value) {
          controller.controllerOverlay.show();
        } else {
          controller.controllerOverlay.hide();
        }
      },
      child: controller.isMoreSelected.value == false
          ? Container(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      EraText(
                        text: 'MORE',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: EraTheme.subHeader,
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  SizedBox(height: 4),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 2,
                    width: 20,
                    color: controller.isMoreSelected.value
                        ? AppColors.kRedColor
                        : Colors.transparent,
                  ),
                ],
              ),
            )
          : OverlayPortal(
              controller: controller.controllerOverlay,
              overlayChildBuilder: (BuildContext context) {
                return Positioned(
                  top: 75.h,
                  right: Get.width / 2.1,
                  child: Wrap(
                    children: [
                      Container(
                        // height: Get.height,
                        width: 220.w,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.r),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: controller.items.sublist(5).map((item) {
                            return ListTile(
                              title: Column(
                                children: [
                                  EraText(
                                    textAlign: TextAlign.center,
                                    text: item,
                                    color:
                                        controller.navBarSelectedIndex.value ==
                                                controller.items.indexOf(item)
                                            ? AppColors.kRedColor
                                            : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: EraTheme.subHeader,
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    height: 2,
                                    width: 20,
                                    color:
                                        controller.navBarSelectedIndex.value ==
                                                controller.items.indexOf(item)
                                            ? AppColors.kRedColor
                                            : Colors.transparent,
                                  ),
                                ],
                              ),
                              onTap: () {
                                controller.navBarSelectedIndex.value =
                                    controller.items.indexOf(item);
                                controller.onNavbarItemSelected(
                                    controller.navBarSelectedIndex.value);
                                controller.controllerOverlay.hide();
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: EraText(
                          text: 'MORE',
                          color: AppColors.kRedColor,
                          fontWeight: FontWeight.bold,
                          fontSize: EraTheme.subHeader,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  SizedBox(height: 4),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: 2,
                    width: 20,
                    color: controller.isMoreSelected.value
                        ? AppColors.kRedColor
                        : Colors.transparent,
                  ),
                ],
              ),
            ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    this.width,
    this.child,
  });
  final Widget? child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200,
      height: 250.h,
      child: Card(
        color: AppColors.white,
        child: child,
      ),
    );
  }
}

Widget agentProfile() {
  return CloudStorage().imageLoaderProvider(
    reference: user!.image,
    width: 100.h,
    height: 100.h,
    // borderRadius: BorderRadius.circular(999),
    shadow: [
      BoxShadow(
          spreadRadius: 2,
          blurRadius: 10,
          color: Colors.black.withOpacity(0.2),
          offset: Offset(1, 1))
    ],
  );
}
