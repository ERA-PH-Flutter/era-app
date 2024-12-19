import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../presentation/global.dart';
import '../../../presentation/website/authentication.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/theme.dart';
import '../app_text.dart';

class Navbar extends GetResponsiveView<HomsController> {
  Navbar()
      : super(
          settings: ResponsiveScreenSettings(
            desktopChangePoint: 1000,
            tabletChangePoint: 768,
            watchChangePoint: 300,
          ),
        );

  @override
  Widget desktop() {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(RouteString.home),
              child: Image.asset(
                AppEraAssets.eraPh,
                height: 250.h,
              ),
            ),
            Spacer(),
            ..._buildNavItems(controller.items),
            Spacer(),
            user == null
                ? ElevatedButton(
                    onPressed: () => showAuthenticationDialog(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kRedColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 24.h),
                    ),
                    child: EraText(
                      text: "AGENT/BROKER LOGIN",
                      fontSize: EraTheme.h6,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  )
                : _showOverlayProfile(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNavItems(List<String> items) {
    return items.map((item) {
      final isActive =
          controller.navBarSelectedIndex.value == items.indexOf(item);
      return InkWell(
        onTap: () {
          controller.navBarSelectedIndex.value = items.indexOf(item);
          controller.onNavbarItemSelected(items.indexOf(item));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EraText(
                text: item,
                color: isActive ? AppColors.kRedColor : Colors.black,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: EraTheme.h6 - 3.sp,
              ),
              if (isActive)
                Container(
                  margin: EdgeInsets.only(top: 4.h),
                  height: 2,
                  width: 24.w,
                  color: AppColors.kRedColor,
                ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _showOverlayProfile() {
    return GestureDetector(
      onTap: () => controller.loginOverlay.toggle(),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user!.image!),
            radius: 20.h,
          ),
          Icon(Icons.arrow_drop_down),
        ],
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
    shadow: [
      BoxShadow(
          spreadRadius: 2,
          blurRadius: 10,
          color: Colors.black.withOpacity(0.2),
          offset: Offset(1, 1))
    ],
  );
}
