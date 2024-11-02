import 'package:eraphilippines/presentation/website/homepage/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
  Widget desktop() {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(
            horizontal: EraTheme.paddingWidthAdmin * 2.7.w),
        height: 100.h,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: AppColors.white,
              child: Image.asset(
                AppEraAssets.eraPh,
                height: 120.h,
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildNavItems(controller.items.sublist(0, 5)),
            )),
            //_showOverlay(),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Button(
                borderRadius: BorderRadius.circular(20),
                width: 300.w,
                onTap: () {
                  print('Login button clicked!');
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
            EraText(
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
            SizedBox(height: 4),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: 2,
              width: 20,
              color:

                  // controller.navBarSelectedIndex.value ==
                  //         controller.items.indexOf(item)
                  //     ? AppColors.kRedColor
                  //     : Colors.transparent
                  controller.isMoreSelected.value == true
                      ? Colors.transparent
                      : controller.navBarSelectedIndex.value ==
                              controller.items.indexOf(item)
                          ? AppColors.kRedColor
                          : Colors.transparent,
            ),
          ],
        ),
      ));
      if (item == 'PROJECTS') {
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
          ? Column(
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
            )
          : OverlayPortal(
              controller: controller.controllerOverlay,
              overlayChildBuilder: (BuildContext context) {
                return Positioned(
                  top: 70.h,
                  right: Get.width / 1.9 + 10.w,
                  child: Wrap(
                    children: [
                      Container(
                        height: 270.w,
                        width: 200.w,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.r),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: controller.items.sublist(5).map((item) {
                            return ListTile(
                              title: Column(
                                children: [
                                  EraText(
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
                      EraText(
                        text: 'MORE',
                        color: AppColors.kRedColor,
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
            ),
    );
  }
}
