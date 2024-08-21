import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
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
      body: SafeArea(
        child: Stack(
          children: [
            Column(),
            SharedWidgets.paddingText('CREATE AN ACCOUNT', FontWeight.w500),
            Positioned(
                top: 80.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: EraText(
                    text: 'You\'re almost there!',
                    color: AppColors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            Positioned.fill(
              top: 150.h,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 25.h,left: 25.h,top: 35.h,bottom: 25.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SharedWidgets.dropDown(
                          controller.selectedStatus,
                          controller.statusType,
                          (value) => controller.selectedStatus.value = value!,
                          'What is your Status',
                          'What is your Status',
                        ),
                        SizedBox(height: 20.h),
                        SharedWidgets.textFormfield(
                            'N/A if not applicable',
                            TextInputType.text,
                            'Who is your Recruiter',
                            controller.recruiter),
                        SizedBox(height: 20.h),
                        SharedWidgets.dropDown(
                          controller.selectedEducation,
                          controller.educationType,
                          (value) =>
                              controller.selectedEducation.value = value!,
                          'Highest Education Level',
                          'Highest Education Level',
                        ),
                        SizedBox(height: 20.h),
                        SharedWidgets.textFormfield('', TextInputType.number,
                            'Years of Experience', controller.experience),
                        SizedBox(height: 20.h),
                        SharedWidgets.dropDown(
                          controller.selectedTransaction,
                          controller.transaction,
                          (value) =>
                              controller.selectedTransaction.value = value!,
                          'Total Number of Transaction',
                          ' ',
                        ),
                        SizedBox(height: 20.h),
                        SharedWidgets.dropDown(
                          controller.selectedTransaction,
                          controller.transaction,
                          (value) =>
                              controller.selectedTransaction5years.value = value!,
                          'Total Number of Transaction in the Past 5 years',
                          ' ',
                        ),
                        SizedBox(height: 20.h),
                        SharedWidgets.dropDown(
                          controller.selectedSpeciality,
                          controller.specialityType,
                          (value) =>
                              controller.selectedSpeciality.value = value!,
                          'Specialization',
                          'Specialization',
                        ),
                        SizedBox(height: 20.h),
                        Button(
                          margin: EdgeInsets.zero,
                          width: Get.width,
                          height: 50.h,
                          bgColor: AppColors.kRedColor,
                          text: 'CREATE',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          onTap: () {
                            controller.signUp();
                          },
                          borderRadius: BorderRadius.circular(10),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}