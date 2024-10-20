import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Screens {
  static Widget loading({height}) {
    return SizedBox(
        height: height ?? Get.height - 250.h,
        child: Center(
          child: Image.asset('assets/icons/loading.gif',
              gaplessPlayback: true,
              height: 50.h,
              width: 50.h,
              fit: BoxFit.fill),
          //   CircularProgressIndicator(
          // backgroundColor: AppColors.white,
          // valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
        ));
  }

  static Widget error() {
    return Container();
  }

  static empty({height}) {
    return SizedBox(
      height: height,
      child: Center(
        child: EraText(
          text: "No Data Found!",
          color: Colors.black,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
