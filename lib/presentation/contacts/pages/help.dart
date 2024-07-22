import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: 'FAQs',
              fontSize: 25.sp,
              color: AppColors.blue,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 20.h),
            BoxWidget(
              child: Column(
                children: [
                  AppTextField(
                    hint: 'AI Search',
                    svgIcon: 'assets/icons/send.png',
                    bgColor: AppColors.white,
                  ),
                  SizedBox(height: 10.h),
                  SearchWidget(),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            EraText(
              text: 'Why ERA?',
              fontSize: 25.sp,
              color: AppColors.kRedColor,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10.h),
            //add bullet dots
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: 'Projects',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Resale',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Rental',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Auction',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Research & Insights',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Find Your Trusted Adviser',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Fees & Commission Guide',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            EraText(
              text: 'About Us',
              fontSize: 25.sp,
              color: AppColors.kRedColor,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10.h),
            //add bullet dots
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: 'We Are ERA',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Our Services',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Contact Us',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Press Room',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Careers',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Privacy Policy',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  EraText(
                    text: 'Security Advisory',
                    fontSize: 20.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
