import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/contacts/pages/findus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Inquiry extends StatelessWidget {
  const Inquiry({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          EraText(
            text: 'INQUIRE NOW FOR DETAILS ON\n   AVAILABILITY AND PRICING',
            fontSize: 23,
            color: AppColors.kRedColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                    text: 'FIRST NAME*',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
                SizedBox(height: 2.h),
                TextformfieldWidget(
                  hintText: 'Enter your First Name',
                  maxLines: 1,
                ),
                SizedBox(height: 5.h),
                EraText(
                    text: 'LAST NAME*',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
                SizedBox(height: 2.h),
                TextformfieldWidget(
                  hintText: 'Enter your Last Name',
                  maxLines: 1,
                ),
                SizedBox(height: 5.h),
                EraText(
                    text: 'EMAIL*',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
                SizedBox(height: 2.h),
                TextformfieldWidget(
                  hintText: 'Enter EmaiL',
                  maxLines: 1,
                ),
                SizedBox(height: 5.h),
                EraText(
                    text: 'MOBILE NUMBER*',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
                SizedBox(height: 2.h),
                TextformfieldWidget(
                  hintText: 'Enter Mobile Number',
                  maxLines: 1,
                ),
                SizedBox(height: 5.h),
                EraText(
                    text: 'DESCRIPTION*',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
                SizedBox(height: 2.h),
                TextformfieldWidget(
                  hintText: 'Enter Description',
                  maxLines: 10,
                ),
                SizedBox(height: 20.h),
                Button.button2(350.w, 40.h, () {
                  // test print('Send');
                }, 'Send'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
