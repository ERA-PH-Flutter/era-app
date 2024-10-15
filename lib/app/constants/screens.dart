import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Screens {
  static Widget loading({height}) {
    return SizedBox(
      height: height ?? Get.height - 250.h,
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: AppColors.white,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
      )
          // Image.asset(
          //     'assets/images/loading.gif',
          //     gaplessPlayback: true,
          //     height: 100.h,
          //     width: 100.h,
          //     fit: BoxFit.fill
          // ),
          ),
    );
  }

  static Widget error() {
    return Container();
  }

  static empty() {
    return Container();
  }
}
