import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
                    Get.toNamed("/home");
                  },
                  child: Icon(
                    CupertinoIcons.forward,
                    color: AppColors.black,
                  ),
                ),
                Column(
                  children: [
                    AspectRatio(
                     aspectRatio: 6/5,
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
                            Obx(() => TextFormField(
                                controller: controller.password,
                                obscureText: !controller.passwordVisible.value,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 15.sp),
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: AppColors.hint),
                                  fillColor: AppColors.white,
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(controller
                                            .passwordVisible.value
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
                                    width: Get.width,
                                    onTap: () {
                                      controller.login();
                                    },
                                    text: "L O G I N",
                                    bgColor: AppColors.kRedColor,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 48.h
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 40.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    )),
                    EraText(
                      text: 'or',
                      color: AppColors.black,
                      fontSize: 18.sp,
                    ),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 40.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    )),
                  ],
                ),
                SizedBox(height: 20.h),
                //not final
                // GestureDetector(
                //   onTap: () {
                //     // Get.toNamed("");
                //   },
                //   child: Container(
                //     margin: EdgeInsets.symmetric(
                //       horizontal: 40,
                //     ),
                //     height: 40.h,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: AppColors.blue,
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         EraText(
                //           text: 'G',
                //           color: AppColors.white,
                //           fontSize: 30.sp,
                //           fontWeight: FontWeight.bold,
                //         ),
                //         SizedBox(width: 10.w),
                //         EraText(
                //           text: 'Sign in with Google',
                //           color: AppColors.white,
                //           fontSize: 15.sp,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Button(
                  onTap: () {
                    controller.googleLogin();
                  },
                  //maybe insert logo here "G"
                  text: "Sign in with Google",
                  bgColor: AppColors.blue,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  width: Get.width,
                  height: 48.h,
                ),
                SizedBox(height: 30.h),
                Button(
                  onTap: () {
                    Get.toNamed("/createaccount");
                  },
                  text: "CREATE ACCOUNT",
                  bgColor: AppColors.kRedColor,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  width: Get.width,
                  height: 48.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
