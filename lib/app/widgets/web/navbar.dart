import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../presentation/website/authentication.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/theme.dart';
import '../app_text.dart';
import '../button.dart';

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
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth200),
        height: Get.height,
        width: Get.width,
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

            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Button(
                borderRadius: BorderRadius.circular(20),
                width: 300.w,
                onTap: () {
                  print('Login button clicked!');
                  showAuthenticationDialog();
                },
                text: "AGENT/BROKER LOGIN",
                bgColor: AppColors.kRedColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
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
          controller.isMoreSelected.value = false;

          controller.navBarSelectedIndex.value = controller.items.indexOf(item);
          controller.onNavbarItemSelected(controller.navBarSelectedIndex.value);
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

  Widget _showOverlay() {
    return GestureDetector(
      onTap: () {
        controller.isMoreSelected.value = !controller.isMoreSelected.value;

        controller.controllerOverlay.isShowing
            ? controller.controllerOverlay.hide()
            : controller.controllerOverlay.show();
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
                  top: 80.h,
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
