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
  final WebLandingPageController controller;
  final double shortestSide;
  final Function(int) navItemSelected;

  CustomAppBarWeb({
    required this.controller,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          AppEraAssets.eraPh,
          height: 120.h,
          width: 230.h,
        ),
        navigation(controller),
        Container(
          width: Get.width / 4,
          child: Button(
            margin: EdgeInsets.only(left: 30.w),
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
                controller.controller.isShowing
                    ? controller.controller.hide()
                    : controller.controller.show();
              },
              child: OverlayPortal(
                controller: controller.controller,
                overlayChildBuilder: (BuildContext context) {
                  return Positioned(
                    top: 103,
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
    return Flexible(
      child: Wrap(
        children: [
          navLink(
              text: 'Home'.toUpperCase(), onPressed: () => navItemSelected(0)),
          sbw10(),
          navLink(
              text: 'Buy'.toUpperCase(), onPressed: () => navItemSelected(1)),
          sbw10(),
          navLink(
              text: 'Rent'.toUpperCase(), onPressed: () => navItemSelected(2)),
          sbw10(),
          navLink(
              text: 'Sell'.toUpperCase(), onPressed: () => navItemSelected(3)),
          sbw10(),
          navLink(
              text: 'Projects'.toUpperCase(),
              onPressed: () => navItemSelected(4)),
          sbw10(),
          navLink(
              text: 'News'.toUpperCase(), onPressed: () => navItemSelected(5)),
          sbw10(),
          navLink(
              text: 'About Us'.toUpperCase(),
              onPressed: () => navItemSelected(6)),
          sbw10(),
          navLink(
              text: 'Contact Us'.toUpperCase(),
              onPressed: () => navItemSelected(7)),
          sbw10(),
          navLink(
              text: 'Find Agents'.toUpperCase(),
              onPressed: () => navItemSelected(8)),
          sbw10(),
          navLink(
              text: 'Mortgage Calculator'.toUpperCase(),
              onPressed: () => navItemSelected(9)),
        ],
      ),
    );
  }

  Widget navLink({
    required String text,
    required Function onPressed,
  }) {
    return TextButton(
      onPressed: () => onPressed(),
      child: EraText(
        text: text,
        color: AppColors.hint,
        fontWeight: FontWeight.bold,
        fontSize: EraTheme.subHeader - 5.sp,
      ),
    );
  }

  Widget _buildMenuCard(String title, Function onTap, bool isSelected) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () => onTap(),
    );
  }
}
