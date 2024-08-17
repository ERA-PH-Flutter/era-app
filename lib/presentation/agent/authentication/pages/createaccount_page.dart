import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
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
        body: SingleChildScrollView(
          child: SafeArea(
              child: Stack(
            children: [
              SharedWidgets.backgroundColumn(),
              SharedWidgets.paddingText('CREATE AN ACCOUNT', FontWeight.bold),
              Positioned(
                top: 200.h,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Column(
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            child: SharedWidgets.textFormfield('First Name',
                                TextInputType.text, 'First Name',
                                controller.firstName),
                          ),
                          SizedBox(width: 10.w,),
                          Flexible(
                            child: SharedWidgets.textFormfield('Last Name',
                                TextInputType.text, 'Last Name',
                                controller.lastName),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      SharedWidgets.textFormfield(
                          'Age', TextInputType.number, 'Age',
                          controller.age),
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
                        controller.contactNo,
                      ),
                      SizedBox(height: 20.h),
                      SharedWidgets.textFormfield(
                          'example@mail.com',
                          TextInputType.text,
                          'Email Address',
                          controller.emailAd),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 40.h,
                left: 0,
                right: 0,
                child: Button(
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                  width: Get.width,
                  height: 50.h,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  bgColor: AppColors.kRedColor,
                  text: 'CONTINUE',
                  onTap: () {
                    Get.to(() => Nextpage());
                  },
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          )),
        ));
  }
}
