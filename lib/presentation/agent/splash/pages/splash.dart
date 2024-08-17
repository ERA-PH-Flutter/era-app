import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/app_text.dart';
import '../controllers/splash_controller.dart';

class Splash extends GetView<SplashController> {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.splashState.value == SplashState.loading) {
            return _loading();
          } else if (controller.splashState.value == SplashState.loaded) {
            return _loaded();
          } else {
            return _error();
          }
        }),
      ),
    );
  }

  _loaded() {}
  _loading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/eraph_logo.png',
            height: Get.width / 1.4,
          ),
          SizedBox(height: 35.h,),
          Obx(()=>EraText(
            text: controller.strings[controller.currentIndex].substring(0, controller.currentCharIndex.value),
            color: AppColors.black,
            textAlign: TextAlign.center,
            fontSize: 30.sp,
            maxLines: 20,
            fontWeight: FontWeight.w600,
          ))
        ],
      ),
    );
  }

  _error() {}
}
