import 'package:architecture/app/constants/colors.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("Skip",
                      style: TextStyle(
                        color: AppColors.hint,
                      )),
                ),
                SizedBox(height: 20.h),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/eraicon.png",
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(color: AppColors.primary),
                                  fillColor: AppColors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFA32920),
                                        width: 2.0),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text("Password",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.visibility_off),
                                  hintStyle:
                                      TextStyle(color: AppColors.primary),
                                  fillColor: AppColors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 163, 41, 32),
                                        width: 2.0),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/home");
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: double.maxFinite,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 20, 49, 141),
                    ),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ),
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