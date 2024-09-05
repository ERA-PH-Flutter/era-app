import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../app/constants/sized_box.dart';

class Inquiry extends StatelessWidget {
  const Inquiry({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(21.w),
      child: Column(
        children: [
          EraText(
            text: 'Inquire now for details on availability and pricing',
            fontSize: 25.sp,
            color: AppColors.kRedColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                  text: 'FIRST NAME*',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
              SizedBox(height: 2.h),
              TextformfieldWidget(
                hintText: 'Enter Your First Name',
                maxLines: 1,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 5.h),
              EraText(
                text: 'LAST NAME*',
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              SizedBox(height: 2.h),
              TextformfieldWidget(
                hintText: 'Enter Your Last Name',
                maxLines: 1,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 5.h),
              EraText(
                text: 'EMAIL*',
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              SizedBox(height: 2.h),
              TextformfieldWidget(
                hintText: 'Enter EmaiL',
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 5.h),
              EraText(
                text: 'MOBILE NUMBER*',
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              SizedBox(height: 2.h),
              TextformfieldWidget(
                hintText: 'Enter Mobile Number',
                maxLines: 1,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 5.h),
              EraText(
                text: 'DESCRIPTION*',
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              SizedBox(height: 2.h),
              TextformfieldWidget(
                hintText: 'Enter Description',
                maxLines: 10,
                keyboardType: TextInputType.text,
              ),
              sb30(),
              Button.button2(Get.width, 48.h, () {
                // test print('Send');
              }, 'Send'),
              sb10(),
            ],
          )
        ],
      ),
    );
  }
}
