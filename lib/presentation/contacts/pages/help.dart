import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Padding(
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
              SizedBox(height: 10.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: EraText(
                  text: 'Account Name,\nWhat do you want yo know?',
                  fontSize: 25.sp,
                  color: AppColors.kRedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
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
                text: 'Why ERA Philippines?',
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
                      text: '• Guide for Getting Started',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    EraText(
                      text: '• Access and Manage Your Account',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              EraText(
                text: 'More Topics',
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
                      text: '• Community Forums',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    EraText(
                      text: '• How to Use the Mortgage\n  Calculator',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    EraText(
                      text: '• New Real Estate Agents Guide to\n  Selling',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    EraText(
                      text: '• Agent or Broker, What’s the\n  Difference',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              EraText(
                text: 'Explore More',
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
                      text: '• Projects',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    EraText(
                      text: '• Resale',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    EraText(
                      text: '• Rental',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    EraText(
                      text: '• Auction',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    EraText(
                      text: '• Research & Insights',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    EraText(
                      text: '• Find Your Trusted Adviser',
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    EraText(
                      text: '• Fees & Commission Guide',
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
      ),
    );
  }
}
