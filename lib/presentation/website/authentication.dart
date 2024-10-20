import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/agent/authentication/controllers/authentication_controller.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../repository/user.dart';
import '../agent/utility/controller/base_controller.dart';
import '../global.dart';

var email = TextEditingController();
var pass = TextEditingController();
RxBool isPasswordNotVisible = true.obs;
void showAuthenticationDialog() {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: Container(
          height: Get.height / 1.3,
          width: Get.width / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), // Nicely rounded corners
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/bg_login_page.png',
                  ),
                  fit: BoxFit.none)),
          child: Padding(
            padding: EdgeInsets.all(EraTheme.paddingWidth + 20.w),
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/eraph_logo.png',
                    fit: BoxFit.cover,
                    height: Get.height / 3,
                  ),
                ),
                SizedBox(
                  width: 300.w,
                  child: TextFormField(
                    controller: email,
                    style: TextStyle(color: AppColors.black, fontSize: 15.sp),
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
                      obscureText: isPasswordNotVisible.value,
                      style: TextStyle(color: AppColors.black, fontSize: 15.sp),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: AppColors.hint),
                        fillColor: AppColors.white,
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordNotVisible.value
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill),
                          onPressed: () {
                            isPasswordNotVisible.value =
                                !isPasswordNotVisible.value;
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
                          onTap: () async {
                            BaseController().showLoading();
                            var login = await Authentication()
                                .login(email: email.text, password: pass.text);
                            if (FirebaseAuth.instance.currentUser != null) {
                              BaseController().hideLoading();
                              user = await EraUser().getById(
                                  FirebaseAuth.instance.currentUser!.uid);
                              if (user!.role!.toLowerCase() != "admin") {
                                user = null;
                                await Authentication().logout();
                                BaseController().showSuccessDialog(
                                    title: "ERROR",
                                    description:
                                        "Please use admin account to have access!",
                                    hitApi: () {
                                      Get.back();
                                    });
                              } else {
                                Get.toNamed(RouteString.landingPage);
                              }
                            } else {
                              BaseController().showSuccessDialog(
                                  title: "ERROR",
                                  description: "Password or email incorrect",
                                  hitApi: () {
                                    Get.back();
                                    Get.back();
                                  });
                            }
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
                      sb50(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class AuthenticationPageWeb extends GetView {
  AuthenticationPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.put(LoginPageController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(EraTheme.paddingWidth + 20.w),
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/eraph_logo.png',
                    fit: BoxFit.cover,
                    height: Get.height / 2,
                  ),
                ),

                SizedBox(
                  width: 300.w,
                  child: TextFormField(
                    controller: email,
                    style: TextStyle(color: AppColors.black, fontSize: 15.sp),
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
                      obscureText: isPasswordNotVisible.value,
                      style: TextStyle(color: AppColors.black, fontSize: 15.sp),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: AppColors.hint),
                        fillColor: AppColors.white,
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordNotVisible.value
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill),
                          onPressed: () {
                            isPasswordNotVisible.value =
                                !isPasswordNotVisible.value;
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
                          onTap: () async {
                            BaseController().showLoading();
                            var login = await Authentication()
                                .login(email: email.text, password: pass.text);
                            if (FirebaseAuth.instance.currentUser != null) {
                              BaseController().hideLoading();
                              user = await EraUser().getById(
                                  FirebaseAuth.instance.currentUser!.uid);
                              if (user!.role!.toLowerCase() != "admin") {
                                user = null;
                                await Authentication().logout();
                                BaseController().showSuccessDialog(
                                    title: "ERROR",
                                    description:
                                        "Please use admin account to have access!",
                                    hitApi: () {
                                      Get.back();
                                    });
                              } else {
                                Get.toNamed(RouteString.landingPage);
                              }
                            } else {
                              BaseController().showSuccessDialog(
                                  title: "ERROR",
                                  description: "Password or email incorrect",
                                  hitApi: () {
                                    Get.back();
                                    Get.back();
                                  });
                            }
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
                      sb50(),
                    ],
                  ),
                ),
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
