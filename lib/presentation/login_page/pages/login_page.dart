import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/login_page_controller.dart';

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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/images/eraph_logo.png",
                    ),
                    SizedBox(height: 30.h),
                    Column(
                      children: [
                        SizedBox(height: 20.h),
                        Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: TextFormField(
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
                                      width: 1.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Obx(()=>TextFormField(
                                controller: controller.password,
                                obscureText: controller.passwordVisible.value,
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 15.sp),
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: AppColors.hint),
                                  fillColor: AppColors.white,
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        controller.passwordVisible.value ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill
                                    ),
                                    onPressed: (){
                                      controller.passwordVisible.value = !controller.passwordVisible.value;
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColors.black,
                                      width: 1.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),)
                            ),
                            SizedBox(height: 20.h),
                            Column(
                              children: [
                                Button(
                                  onTap: () {
                                    controller.login();
                                  },
                                  text: "L O G I N",
                                  bgColor: AppColors.kRedColor,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(height: 20.h),
                                GestureDetector(
                                  onTap: () {
                                    // Get.toNamed("");
                                  },
                                  child: FarmerText(
                                    text: 'Forgot Password?',
                                    color: AppColors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FarmerText(
                        text: 'or',
                        color: AppColors.black,
                        fontSize: 18.sp,
                      ),
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
                //         FarmerText(
                //           text: 'G',
                //           color: AppColors.white,
                //           fontSize: 30.sp,
                //           fontWeight: FontWeight.bold,
                //         ),
                //         SizedBox(width: 10.w),
                //         FarmerText(
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
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 30.h),
                Button(
                  onTap: () {
                    Get.toNamed("/home");
                  },
                  text: "CREATE ACCOUNT",
                  bgColor: AppColors.kRedColor,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}