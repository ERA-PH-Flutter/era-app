import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';
import 'nextPage.dart';

class CreateAccount extends GetView<LoginPageController> {
  const CreateAccount({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kRedColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SharedWidgets.backgroundColumn(),
              SharedWidgets.paddingText('CREATE AN ACCOUNT', FontWeight.bold),
              Container(
                margin: EdgeInsets.only(top: 40.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: 25.w, left: 25.w, top: 25.h, bottom: 25.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            child: SharedWidgets.textFormfield(
                                'First Name',
                                TextInputType.text,
                                'First Name',
                                controller.firstName),
                          ),
                          SizedBox(width: 10.w),
                          Flexible(
                            child: SharedWidgets.textFormfield(
                                'Last Name',
                                TextInputType.text,
                                'Last Name',
                                controller.lastName),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      EraText(
                          text: 'Password',
                          fontSize: 18.sp,
                          color: AppColors.black),
                      //password
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordC,
                          obscureText: !controller.passwordVisible.value,
                          style: TextStyle(
                              color: AppColors.black, fontSize: 18.sp),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: AppColors.hint, fontSize: 18.sp),
                            labelStyle: TextStyle(color: AppColors.hint),
                            filled: false,
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
                              borderSide: BorderSide(color: AppColors.hint),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: AppColors.hint),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SharedWidgets.textFormfield(
                          'Age', TextInputType.number, 'Age', controller.age),
                      SizedBox(height: 30.h),
                      SharedWidgets.dropDown(
                          controller.selectedGender,
                          controller.genderType,
                          (value) => controller.selectedGender.value = value!,
                          'Gender',
                          'Gender'),
                      SizedBox(height: 20.h),
                      SharedWidgets.textFormfield(
                          '0000-000-0000',
                          TextInputType.number,
                          'Contact Number',
                          controller.contactNo),
                      SizedBox(height: 20.h),
                      SharedWidgets.textFormfield(
                          'example@mail.com',
                          TextInputType.text,
                          'Email Address',
                          controller.emailAd),
                      SizedBox(height: 20.h),
                      Button(
                        margin: EdgeInsets.zero,
                        width: Get.width,
                        height: 50.h,
                        bgColor: AppColors.kRedColor,
                        text: 'CONTINUE',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        onTap: () {
                          Get.to(() => Nextpage());
                        },
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
