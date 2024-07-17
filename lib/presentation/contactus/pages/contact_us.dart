import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactUs extends GetView<HomeController> {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppbar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: "CONTACT US",
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blue,
                ),
                EraText(
                  text: "Want to learn more about ERA Philippines?  ",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kRedColor,
                ),
                SizedBox(height: 20.h),
                EraText(
                    text: 'Tell us about your inquiry',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                SizedBox(height: 5.h),
                TextFormField(
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
                SizedBox(height: 20.h),
                EraText(
                    text: 'Name',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                SizedBox(height: 5.h),
                TextFormField(
                  style: TextStyle(color: AppColors.black, fontSize: 15.sp),
                  decoration: InputDecoration(
                    hintText: 'Name',
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
                TextformfieldWidget(
                  decoration: InputDecoration(
                    hintText: '0000-0000-0000',
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
                )
              ],
            ),
          ),
        ));
  }
}
