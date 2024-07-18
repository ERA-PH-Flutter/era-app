import 'dart:io';

import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/authentication/controllers/login_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends GetView<LoginPageController> {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(),
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: 'CREATE ACCOUNT',
                  fontSize: 25.sp,
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600,
                ),
                EraText(
                    text: 'Join Us Today!',
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kRedColor),
                SizedBox(height: 20.h),
                EraText(
                  text:
                      'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.\n\nERA Real Estate was founded on the principle of collaboration. The idea that by working together and supporting one another, we can create a stronger, more knowledgeable community of real estate professionals who are better prepared serve your unique needs.',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  maxLines: 20,
                ),
                SizedBox(height: 10.h),
                EraText(
                    text: 'CREATE PROFILE',
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kRedColor),
                SizedBox(height: 20.h),
                EraText(
                    text: 'Profile Photo',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                Obx(() => controller.image.value.path == ''
                    ? IconButton(
                        onPressed: () {
                          controller.getImageGallery();
                        },
                        icon: Image.asset('assets/icons/uploadphoto.png'),
                      )
                    : Image.file(
                        controller.image.value,
                        fit: BoxFit.cover,
                      )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: EraText(
                      text: 'Photo must be at least 300px X 300px',
                      fontSize: 15.sp,
                      color: AppColors.hint),
                ),
                SizedBox(height: 20.h),
                EraText(
                    text: 'Name',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                SizedBox(height: 5.h),
                TextformfieldWidget(
                  hintText: 'Name',
                  maxLines: 1,
                ),
                SizedBox(height: 20.h),
                EraText(
                    text: 'WhatsApp Number',
                    fontSize: 20.sp,
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
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                SizedBox(height: 5.h),
                TextformfieldWidget(
                  hintText: 'Your Email here',
                  maxLines: 1,
                ),
                SizedBox(height: 20.h),
                EraText(
                    text: 'Confirm Email',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                SizedBox(height: 5.h),
                TextformfieldWidget(
                  hintText: 'Confirm Email',
                  maxLines: 1,
                ),
                SizedBox(height: 20.h),
                EraText(
                    text: 'Password',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                SizedBox(height: 5.h),
                TextformfieldWidget(
                  hintText: 'Password',
                  maxLines: 1,
                ),
                SizedBox(height: 20.h),
                EraText(
                    text: 'Confirm Passowrd',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                SizedBox(height: 5.h),
                TextformfieldWidget(
                  hintText: 'Confirm Passowrd',
                  maxLines: 1,
                ),
                SizedBox(height: 20.h),
                Button.button2(300.w, 40.h, () {}, 'CREATE ACCOUNT'),
                SizedBox(height: 20.h),

                // Button(
                //   text: 'CREATE ACCOUNT',
                //   onTap: () {},
                //   bgColor: AppColors.kRedColor,
                //   borderRadius: BorderRadius.circular(10),
                //   height: 50.h,
                //   width: 300.w,
                // ),
              ],
            ),
          )),
        ));
  }
}