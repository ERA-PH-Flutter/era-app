import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
      width: 500.w,
      height: 400.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/project-main%2Fdivider_bg.jpeg?alt=media&token=fa4f5974-ba69-4123-bdee-d044f2ec3600',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/project-main%2Feraph_white-logo.png?alt=media&token=624a65d5-d64e-4272-8055-e47299a32c06',
            fit: BoxFit.cover,
            height: 152.h,
            width: 157.w,
          ),
          EraText(
            text: text ??
                '     CONNECT WORLDS, BUILD\nDREAMS WITH ERA PHILIPPINES:\n  YOUR REAL ESTATE AGENCY\n             PARTNER FOR LIFE',
            color: color ?? AppColors.white,
            fontSize: 16.sp,
          ),
          if (button == true)
            Button(
              text: 'VIEW MORE PROJECTS',
              onTap: () {
                Get.toNamed('/project-main');
              },
              bgColor: AppColors.kRedColor,
              height: 40.h,
              borderRadius: BorderRadius.circular(30),
            ),
        ],
      ),
    );
  }
}
