// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppDivider extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final bool? button;

  const AppDivider(
      {super.key, this.text, this.color, this.fontSize, this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 400.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/divider_bg.jpeg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/eraph_white-logo.png',
            fit: BoxFit.cover,
            //height: 152.h,
            width: 157.w,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: text ??
                '     CONNECT WORLDS, BUILD\nDREAMS WITH ERA PHILIPPINES:\n  YOUR REAL ESTATE AGENCY\n             PARTNER FOR LIFE',
            color: color ?? AppColors.white,
            fontSize: 21.sp,
            maxLines: 20,
          ),
          if (button == true)
            Column(
              children: [
                SizedBox(height: 25.h),
                Button(
                  text: 'FIND MORE PROJECTS',
                  onTap: () {
                    Get.toNamed('/project-main');
                  },
                  bgColor: AppColors.kRedColor,
                  width: 240.w,
                  height: 40.h,
                  borderRadius: BorderRadius.circular(99),
                ),
                SizedBox(height: 25.h),
              ],
            ),
        ],
      ),
    );
  }
}
