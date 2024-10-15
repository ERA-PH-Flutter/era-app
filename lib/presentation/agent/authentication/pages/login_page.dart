import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/agent/home/controllers/home_binding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/widgets/navigation/customenavigationbar.dart';
import '../../../global.dart';
import '../controllers/authentication_controller.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(EraTheme.paddingWidth + 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    pageViewController = PageController(initialPage: 0);
                    currentRoute = '/home';
                    Get.offAll(BaseScaffold(), binding: HomeBinding());
                  },
                  child: Icon(
                    CupertinoIcons.forward,
                    color: AppColors.black,
                  ),
                ),
                Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 6 / 5,
                      child: Image.asset(
                        'assets/images/eraph_logo.png',
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      children: [
                        SizedBox(height: 20.h),
                        Column(
                          children: [
                            TextFormField(
                              controller: controller.email,
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15.sp),
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: AppColors.hint),
                                fillColor: AppColors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.black,
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Obx(
                              () => TextFormField(
                                controller: controller.password,
                                obscureText: !controller.passwordVisible.value,
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 15.sp),
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: AppColors.hint),
                                  fillColor: AppColors.white,
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(controller.passwordVisible.value
                                        ? CupertinoIcons.eye_fill
                                        : CupertinoIcons.eye_slash_fill),
                                    onPressed: () {
                                      controller.passwordVisible.value =
                                          !controller.passwordVisible.value;
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColors.black,
                                      width: 1,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            SizedBox(
                              child: Column(
                                children: [
                                  Button(
                                    borderRadius: BorderRadius.circular(20),
                                    width: Get.width,
                                    onTap: () {
                                      controller.login();
                                    },
                                    text: "L O G I N",
                                    bgColor: AppColors.kRedColor,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(height: 20.h),
                                  GestureDetector(
                                    onTap: () {
                                      // Get.toNamed("");
                                    },
                                    child: EraText(
                                      text: 'Forgot Password?',
                                      color: AppColors.black,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  sb80(),
                                  EraText(
                                    text: 'Don\'t have an account yet?',
                                    color: AppColors.black,
                                    fontSize: 22.sp,
                                  ),
                                  sb10(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/joinEra");
                                    },
                                    child: EraText(
                                      text: 'Sign Up',
                                      color: AppColors.blue,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      textDecoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [

                  ],
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
