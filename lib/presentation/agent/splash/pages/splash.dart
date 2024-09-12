import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:flutter/foundation.dart';
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
          }else if(controller.splashState.value == SplashState.web){
            return _web();
          }else {
            return _error();
          }
        }),
      ),
    );
  }

  _loaded() {}
  _loading() {
    var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;

    return Center(
      child: kIsWeb && user != null
          ? Image.asset(
              'assets/images/Era Splash Logo.png',
              width: Get.width,
            )
          : kIsWeb
              ? Image.asset(
                  'assets/images/Era Splash Logo.png',
                  width: Get.width,
                )
              : shortestSide < 600
                  ? Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/erasplashbg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 120.h),
                          Image.asset(
                            'assets/images/erasplashlogo.png',
                            height: Get.width / 1.4,
                          ),
                          SizedBox(height: 35.h),
                          Obx(
                            () => EraText(
                              text: controller.strings[controller.currentIndex]
                                  .substring(
                                      0, controller.currentCharIndex.value),
                              color: AppColors.white,
                              textAlign: TextAlign.center,
                              fontSize: 25.sp,
                              maxLines: 20,
                              fontWeight: FontWeight.bold,
                              lineHeight: 1.2,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/erasplashbg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 120.h),
                          Image.asset(
                            'assets/images/erasplashlogo.png',
                            height: Get.width / 1.4,
                          ),
                          SizedBox(height: 35.h),
                          Obx(
                            () => EraText(
                              text: controller.strings[controller.currentIndex]
                                  .substring(
                                      0, controller.currentCharIndex.value),
                              color: AppColors.white,
                              textAlign: TextAlign.center,
                              fontSize: 25.sp,
                              maxLines: 20,
                              fontWeight: FontWeight.bold,
                              lineHeight: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
  _web(){
    return Center(
      child: Container(),
    );
  }
  _error() {}
}
