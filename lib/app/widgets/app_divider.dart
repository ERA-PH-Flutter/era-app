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

//    'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/project-main%2Fdivider_bg.jpeg?alt=media&token=fa4f5974-ba69-4123-bdee-d044f2ec3600'
//'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/project-main%2Feraph_white-logo.png?alt=media&token=624a65d5-d64e-4272-8055-e47299a32c06
  const AppDivider(
      {super.key, this.text, this.color, this.fontSize, this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.w,
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
                  text: 'VIEW MORE PROJECTS',
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
