import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
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
      body: SingleChildScrollView(
        child: SafeArea(
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
                contacts()
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget contacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
            text: 'Tell us about yourself',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black),
        SizedBox(height: 5.h),
        TextformfieldWidget(
          hintText: 'Default Text',
          maxLines: 1,
        ),
        SizedBox(height: 20.h),
        EraText(
            text: 'Name',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black),
        SizedBox(height: 5.h),
        TextformfieldWidget(
          hintText: 'Name',
          maxLines: 1,
        ),
        SizedBox(height: 20.h),
        EraText(
            text: 'Phone Number',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black),
        SizedBox(height: 5.h),
        TextformfieldWidget(
          hintText: '000-000-0000',
          maxLines: 1,
        ),
        SizedBox(height: 20.h),
        EraText(
            text: 'Email',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black),
        SizedBox(height: 5.h),
        TextformfieldWidget(
          hintText: 'Your email here',
          maxLines: 1,
        ),
        SizedBox(height: 20.h),
        EraText(
            text: 'Message',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black),
        TextformfieldWidget(
          hintText: 'Your Message',
        ),
        SizedBox(height: 5.h),
        Button.button2(272.w, 40.h, () {}, 'Send'),
        SizedBox(height: 20.h),
      ],
    );
  }
}
