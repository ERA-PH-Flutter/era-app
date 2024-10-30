import 'package:eraphilippines/app/widgets/company/company_items.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../presentation/website/authentication.dart';
import '../../presentation/website/landingpage/controllers/web_landingpage_controller.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../constants/theme.dart';
import 'app_text.dart';
import 'button.dart';

class CustomAppBarWeb extends StatelessWidget implements PreferredSizeWidget {
  final WebLandingPageController webcontroller;
  final double shortestSide;
  final Function(int) navItemSelected;

//    var controller = OverlayPortalController();

  CustomAppBarWeb({
    required this.webcontroller,
    required this.shortestSide,
    required this.navItemSelected,
  });

  @override
  Size get preferredSize => Size.fromHeight(120.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120.h,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      title: shortestSide > 600
          ? _buildWideScreenContent()
          : _buildSmallScreenContent(),
    );
  }

  Widget _buildWideScreenContent() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 1.9),
      child: Row(
        children: [
          Image.asset(
            AppEraAssets.eraPh,
            height: 120.h,
            width: 230.h,
          ),
          navigation(webcontroller),
          Spacer(),
          Container(
            width: Get.width / 4.3,
            child: Button(
              borderRadius: BorderRadius.circular(20),
              width: 300.w,
              onTap: () {
                showAuthenticationDialog();
                //  Get.toNamed(RouteString.webLoginPage);
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
    );
  }

  Widget _buildSmallScreenContent() {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              AppEraAssets.eraPh,
              height: 120.h,
            ),
            GestureDetector(
              onTap: () {
                webcontroller.controller.isShowing
                    ? webcontroller.controller.hide()
                    : webcontroller.controller.show();
              },
              child: OverlayPortal(
                controller: webcontroller.controller,
                overlayChildBuilder: (BuildContext context) {
                  return Positioned(
                    top: 103.h,
                    right: 0,
                    child: Wrap(
                      children: [
                        Container(
                          width: Get.width / 2,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.r),
                            color: Colors.white.withOpacity(0.9),
                          ),
                          child: Column(
                            children: [
                              _buildMenuCard(
                                  'Home', () => navItemSelected(0), true),
                              _buildMenuCard(
                                  'Buy', () => navItemSelected(1), false),
                              _buildMenuCard(
                                  'Rent', () => navItemSelected(2), false),
                              _buildMenuCard(
                                  'Sell', () => navItemSelected(3), false),
                              _buildMenuCard(
                                  'Projects', () => navItemSelected(4), false),
                              _buildMenuCard(
                                  'News', () => navItemSelected(5), false),
                              _buildMenuCard(
                                  'About Us', () => navItemSelected(6), false),
                              _buildMenuCard('Contact Us',
                                  () => navItemSelected(7), false),
                              _buildMenuCard('Find Agents',
                                  () => navItemSelected(8), false),
                              _buildMenuCard('Mortgage Calculator',
                                  () => navItemSelected(9), false),
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
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 100,
          child: Divider(
            thickness: 5,
            color: AppColors.kRedColor,
          ),
        ),
      ],
    );
  }

  Widget navigation(WebLandingPageController controller) {
    return Row(
      children: [
        navLink(
            isSelected: selectedIndex == 0,
            text: 'Home'.toUpperCase(),
            onPressed: () => navItemSelected(0)),
        sbw10(),
        navLink(
            isSelected: selectedIndex == 0,
            text: 'Buy'.toUpperCase(),
            onPressed: () => navItemSelected(1)),
        sbw10(),
        navLink(
            isSelected: selectedIndex == 0,
            text: 'Rent'.toUpperCase(),
            onPressed: () => navItemSelected(2)),
        sbw10(),
        navLink(
            isSelected: selectedIndex == 0,
            text: 'Sell'.toUpperCase(),
            onPressed: () => navItemSelected(3)),
        sbw10(),
        navLink(
            isSelected: selectedIndex == 0,
            text: 'Projects'.toUpperCase(),
            onPressed: () => navItemSelected(4)),
        sbw10(),
        navLink(
            isSelected: selectedIndex == 0,
            text: 'Find Agents'.toUpperCase(),
            onPressed: () => navItemSelected(5)),
        sbw10(),
        GestureDetector(
          onTap: () {
            controller.controller.isShowing
                ? controller.controller.hide()
                : controller.controller.show();
          },
          child: OverlayPortal(
            controller: webcontroller.controller,
            overlayChildBuilder: (BuildContext context) {
              return Positioned(
                top: 70.h,
                right: Get.width / 2.4,
                child: Wrap(
                  children: [
                    Card(
                      color: AppColors.white,
                      elevation: 7,
                      child: Container(
                        height: 270.w,
                        width: 200.w,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          children: [
                            _buildMenuCard(
                                color: AppColors.hint,
                                'NEWS',
                                () => navItemSelected(6),
                                false),
                            _buildMenuCard(
                                color: AppColors.hint,
                                'ABOUT US',
                                () => navItemSelected(7),
                                false),
                            _buildMenuCard(
                                color: AppColors.hint,
                                'CONTACT US',
                                () => navItemSelected(8),
                                false),
                            _buildMenuCard(
                                color: AppColors.hint,
                                'MORTGAGE CALCULATOR',
                                () => navItemSelected(9),
                                false),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              width: 100.w,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EraText(
                    text: 'MORE',
                    color: AppColors.hint,
                    fontWeight: FontWeight.bold,
                    fontSize: EraTheme.subHeader,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.kRedColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget navLink({
    required String text,
    required Function onPressed,
    required bool isSelected,
  }) {
    return Column(
      children: [
        TextButton(
          onPressed: () => onPressed(),
          child: EraText(
            text: text,
            color: AppColors.hint,
            fontWeight: FontWeight.bold,
            fontSize: EraTheme.subHeader,
          ),
        ),
        if (isSelected)
          Container(height: 5.h, color: AppColors.kRedColor)
        else
          SizedBox.shrink(),
      ],
    );
  }

  Widget _buildMenuCard(String title, Function onTap, bool isSelected,
      {Color? color}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.black,
          fontSize: 18.sp,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () => onTap(),
    );
  }
}
