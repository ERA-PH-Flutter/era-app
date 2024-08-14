import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/presentation/agent/authentication/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Nextpage extends GetView<LoginPageController> {
  const Nextpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kRedColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              SharedWidgets.backgroundColumn(),
              SharedWidgets.paddingText('Your Almost\nFinish!'),
              Positioned(
                top: 220.h,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Column(
                    children: [
                      SharedWidgets.dropDown(
                        controller.selectedStatus,
                        controller.statusType,
                        (value) => controller.selectedStatus.value = value!,
                        'What is your Status',
                        'What is your Status',
                      ),
                      SizedBox(height: 30.h),
                      SharedWidgets.textFormfield(
                          'N/A if not applicable',
                          TextInputType.text,
                          'Who is your Recruiter',
                          controller.recruiter),
                      SizedBox(height: 30.h),
                      SharedWidgets.dropDown(
                        controller.selectedEducation,
                        controller.educationType,
                        (value) => controller.selectedEducation.value = value!,
                        'Highest Education Level',
                        'Highest Education Level',
                      ),
                      SizedBox(height: 30.h),
                      SharedWidgets.textFormfield('', TextInputType.number,
                          'Years of Experience', controller.experience),
                      SizedBox(height: 30.h),
                      SharedWidgets.dropDown(
                        controller.selectedSpeciality,
                        controller.specialityType,
                        (value) => controller.selectedSpeciality.value = value!,
                        'Specialization',
                        'Specialization',
                      ),
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
                  bgColor: AppColors.kRedColor,
                  text: 'CONTINUE',
                  onTap: () {
                    Get.to(() => Nextpage());
                  },
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
