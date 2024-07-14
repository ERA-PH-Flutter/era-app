import 'dart:ui';

import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDivider extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;

  const AppDivider({super.key, this.text, this.color, this.fontSize});

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/eraph_logo.png',
            fit: BoxFit.cover,
            height: 152.h,
            width: 157.w,
          ),
          FarmerText(
            text: text ??
                '     CONNECT WORLDS, BUILD\nDREAMS WITH ERA PHILIPPINES:\n  YOUR REAL ESTATE AGENCY\n             PARTNER FOR LIFE',
            color: color ?? AppColors.white,
            fontSize: 16.sp,
          ),
          Button(
            text: 'VIEW MORE PROJECTS',
            onTap: () {},
            bgColor: AppColors.kRedColor,
            height: 40.h,
            borderRadius: BorderRadius.circular(30),
          ),
          //FEATURED LISTINGS
        ],
      ),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [

      //   ],
      // ),
    );
  }
}
