import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/agent/authentication/controllers/authentication_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../agent/utility/controller/base_controller.dart';

class AuthenticationPage extends GetView {
  AuthenticationPage({super.key});
  var email = TextEditingController();
  var pass = TextEditingController();
  RxBool isPasswordNotVisible = true.obs;
  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.put(LoginPageController());
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
                    Get.toNamed("/landingPage");
                  },
                  child: Icon(
                    CupertinoIcons.forward,
                    color: AppColors.black,
                  ),
                ),
                Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 30 / 8,
                      child: Image.asset(
                        'assets/images/eraph_logo.png',
                      ),
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: 300.w,
                              child: TextFormField(
                                controller: email,
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
                            ),
                            SizedBox(height: 20.h),
                            Obx(
                              () => SizedBox(
                                width: 300.w,
                                child: TextFormField(
                                  controller: pass,
                                  obscureText:
                                      isPasswordNotVisible.value,
                                  style: TextStyle(
                                      color: AppColors.black, fontSize: 15.sp),
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: AppColors.hint),
                                    fillColor: AppColors.white,
                                    filled: true,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          controller.passwordVisible.value
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
                            ),
                            SizedBox(height: 30.h),
                            SizedBox(
                              child: Column(
                                children: [
                                  Button(
                                      width: 300.w,
                                      onTap: ()async{
                                        Get.toNamed("/landingPage");
                                        // BaseController().showLoading();
                                        // await Authentication().login(email: email.text,password: pass.text);
                                        // BaseController().hideLoading();
                                      },
                                      text: "L O G I N",
                                      bgColor: AppColors.kRedColor,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600,
                                      height: 48.h),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
