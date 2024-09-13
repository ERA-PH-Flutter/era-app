import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/widgets/custom_appbar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fpic1.JPG?alt=media&token=92a9e2a1-46af-450e-8161-82eb1aa6b501',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 15.h),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                child: EraText(
                    text: 'About Us',
                    fontSize: EraTheme.header - 4.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kRedColor),
              ),
              SizedBox(height: 10.h),
              _buildDescription(
                  'Welcome to a new ERA of property discovery and management.'),
              SizedBox(
                height: 20.h,
              ),
              _buildDescription(
                  'ERA Real Estate Philippines is a proud member of ERA Real Estate, the largest real estate network in the Asia-Pacific region with more than 23,400 trusted advisers in over 640 offices across 13 countries. We provide exceptional real estate services, guiding you through buying, selling, and investing.'),
              SizedBox(
                height: 20.h,
              ),
              _buildDescription(
                  'We are committed to revolutionizing your real estate experience through innovative technology and unparalleled service. Our mission is to make property transactions seamless, transparent, and tailored to your unique needs.'),
              SizedBox(
                height: 20.h,
              ),
              _buildDescription(
                  'We envision a world where searching for and managing real estate is as simple as a few taps on your phone. With the ERA Real Estate Philippines app, we aim to redefine the property landscape in the Philippines by providing cutting-edge tools and resources that enable you to make informed decisions with confidence.'),
              SizedBox(
                height: 20.h,
              ),
              _buildDescription(
                  'At ERA Real Estate Philippines, we empower you to achieve your real estate dreams. Discover the ERA difference today!'),
              SizedBox(height: 20.h),
              _buildDescription('What We Do',
                  fontWeight: FontWeight.w600,
                  fontSize: EraTheme.header - 4.sp,
                  color: AppColors.kRedColor),
              SizedBox(height: 20.h),
              Wrap(
                children: [
                  _buildDescription('Real Estate Brokerage Services:',
                      fontWeight: FontWeight.w600),
                  _buildDescription(
                      'Discover unparalleled expertise and personalized guidance with our premier real estate brokerage services. Whether you’re buying, selling, or investing, our seasoned professionals are committed to guiding you through every step of the process.'),
                ],
              ),
              SizedBox(height: 20.h),
              Wrap(
                children: [
                  _buildDescription('Agent & Broker Training:',
                      fontWeight: FontWeight.w600),
                  _buildDescription(
                      'Elevate the careers of our agents and brokers with our comprehensive training and development programs. Our courses are designed to enhance their skills and boost their success, covering everything from mastering market trends and effective client communication to advanced negotiation tactics and cutting-edge technology.'),
                ],
              ),
              SizedBox(height: 20.h),
              Wrap(
                children: [
                  _buildDescription('Franchise Arrangements:',
                      fontWeight: FontWeight.w600),
                  _buildDescription(
                      'Explore limitless possibilities of real estate franchising through our dynamic franchise arrangements. As part of our network, you’ll benefit from a proven business model, robust marketing support, and extensive operational resources tailored to maximize your growth and profitability.'),
                ],
              ),
              SizedBox(height: 20.h),
              Wrap(
                children: [
                  _buildDescription('Property Valuation: ',
                      fontWeight: FontWeight.w600),
                  _buildDescription(
                      'Accurate property valuation is the cornerstone of successful real estate transactions. At ERA Real Estate Philippines, we offer meticulous property valuation services designed to provide clarity and confidence to buyers, sellers, and investors alike. Backed by comprehensive market analysis and expert insights, our valuation process ensures you receive an informed and fair assessment of your property’s worth.'),
                ],
              ),
              SizedBox(
                height: 40.h,
              )
              // SizedBox(
              //   width: Get.width,
              //   child: Button(
              //     text: "Get Started",
              //     bgColor: AppColors.kRedColor,
              //
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  _buildDescription(text, {fontWeight, fontSize, color}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: EraText(
          text: text,
          maxLines: 50,
          fontSize: fontSize ?? EraTheme.paragraph,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? AppColors.black),
    );
  }

  Widget text(String text) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: EraText(
              text: text,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              maxLines: 50,
            )),
      ],
    );
  }
}
