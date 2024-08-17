import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'contact_us.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  // https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/about-us%2Faboutuspic.png?alt=media&token=0bb205a5-3807-4066-bb1d-18f410d64d9f
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: EraText(
                    text: 'ABOUT US',
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: EraText(
                    text: 'Why join ERA Philippines?',
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kRedColor),
              ),
              SizedBox(height: 5.h),
              Image.asset(
                'assets/images/aboutuspic.png',
                fit: BoxFit.contain,
                width: 500.w,
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: EraText(
                    text:
                        'At ERA Philippines, we take great pride in our sterling brand reputation. As an integral part of the largest international real estate network in the Asia-Pacific region, we provide our agents with abundant opportunities for personal and professional growth.\n\nWhat sets us apart is our commitment to fostering a supportive environment. Through mentorship programs and comprehensive training initiatives, we ensure that our agents are not just equipped with the necessary knowledge, but also receive the guidance and encouragement they need to thrive.\n\nWe understand that success is built on the dedication and hard work of individuals. That\'s why we strive to provide a warm and welcoming community where everyone feels valued. Moreover, we provide a favorable commission structure as we believe in recognizing and rewarding excellence.\n\nAt ERA Philippines, we\'re not just in the business of real estate; we\'re in the business of empowering people to achieve their dreams.\n\nStill searching for the ideal job position?\n\nWe are actively looking for talented individuals to join our team and contribute to our success. Join us in shaping the future of real estate! Start a fulfilling career with ERA Philippines by sending your resume to careers@eraphilippines.com. We\'ll reach out if your skillset aligns with our requirements.',
                    maxLines: 50,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: EraText(
                  text: 'Want to know more?',
                  fontSize: 20.sp,
                  color: AppColors.kRedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ContactUs.contacts(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget text(String text) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: EraText(
          text: text,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          maxLines: 50,
        ));
  }
}
