import 'package:architecture/app/constants/colors.dart';
import 'package:architecture/app/widgets/app_text.dart';
import 'package:architecture/app/widgets/button.dart';
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
                // Padding(
                //   padding: const EdgeInsets.all(15),
                //   child: Text("Skip",
                //       style: TextStyle(
                //         color: AppColors.hint,
                //       )),
                // ),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/eraph_logo.png",
                    ),
                    SizedBox(height: 50.h),
                    Column(
                      children: [
                        SizedBox(height: 20.h),
                        Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: TextFormField(
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 15.sp),
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  hintStyle: TextStyle(color: AppColors.hint),
                                  fillColor: AppColors.white,
                                  filled: true,
                                  // focusedBorder: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   // borderSide: BorderSide(
                                  //   //     color: Color(0xFFA32920), width: 2.0),
                                  // ),
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
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10.0),
                            //   child: Text("Password",
                            //       style: TextStyle(
                            //           fontSize: 15.sp,
                            //           fontWeight: FontWeight.bold)),
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: TextFormField(
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 15.sp),
                                decoration: InputDecoration(
                                  hintText: 'Password',

                                  // suffixIcon: Icon(Icons.visibility_off),
                                  hintStyle: TextStyle(color: AppColors.hint),
                                  fillColor: AppColors.white,
                                  filled: true,
                                  // focusedBorder: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
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
                            Column(
                              children: [
                                Button(
                                  onTap: () {
                                    Get.toNamed("/home");
                                  },
                                  text: "L O G I N",
                                  bgColor: AppColors.kRedColor,
                                  fontSize: 20.sp,
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

                Button(
                  onTap: () {
                    Get.toNamed("/home");
                  },
                  text: "Sign in with Google",
                  bgColor: AppColors.blue,
                  fontSize: 15.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 


       // Obx(() => Text(controller.text.value)),
            // CupertinoButton.filled(
            //     child: Text("change text to hello world"),
            //     onPressed: () {
            //       controller.text.value = "hello world";
            //     }),
            // CupertinoButton(
            //     child: Text("change text to blank"),
            //     onPressed: () {
            //       controller.text.value = "";
            //     }),