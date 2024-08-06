import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/contacts_controller.dart';

class Help extends GetView<ContactusController> {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.w),
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
                  text: 'Account Name,\nWhat do you want to know?',
                  fontSize: 25.sp,
                  color: AppColors.kRedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              BoxWidget.build(
                  child: Column(
                children: [
                  AppTextField(
                    hint: 'AI Search',
                    svgIcon: AppEraAssets.send,
                    bgColor: AppColors.white,
                  ),
                  SizedBox(height: 10.h),
                  SearchWidget.build(() {}),
                ],
              )),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: EraText(
                  text: 'Why ERA Philippines?',
                  fontSize: 25.sp,
                  color: AppColors.kRedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              expansionTile('Guide for Getting Started',
                  'Access and Manage Your Account'),
              SizedBox(height: 15.h),
              expansionTile('Access and Manage Your Account',
                  'Access and Manage Your Account'),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: EraText(
                  text: 'More Topics',
                  fontSize: 25.sp,
                  color: AppColors.kRedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              expansionTile(
                  'Community Forums', 'Access and Manage Your Account'),
              SizedBox(height: 15.h),
              expansionTile('How to Use the Mortgage Calculator',
                  'Access and Manage Your Account'),
              SizedBox(height: 15.h),
              expansionTile('Real Estate Agents Guide to Selling',
                  'Access and Manage Your Account'),
              SizedBox(height: 15.h),
              expansionTile('Agent or Broker, What’s the Difference',
                  'Access and Manage Your Account'),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: EraText(
                  text: 'Explore More',
                  fontSize: 25.sp,
                  color: AppColors.kRedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              expansionTile('Projects', 'Access and Manage Your Account'),
              SizedBox(height: 15.h),
              expansionTile('Resale', 'Access and Manage Your Account'),
              SizedBox(height: 15.h),
              expansionTile('Rental', 'Access and Manage Your Account'),
              SizedBox(height: 15.h),
              expansionTile('Auction', 'Access and Manage Your Account'),
              SizedBox(height: 15.h),
              expansionTile(
                  'Research & Insights', 'Access and Manage Your Account'),
              SizedBox(height: 15.h),
              expansionTile('Find Your Trusted Adviser',
                  'Access and Manage Your Account'),
              SizedBox(height: 15.h),
              expansionTile('Find Your Trusted Adviser',
                  'Access and Manage Your Account'),
              SizedBox(height: 15.h),
              expansionTile(
                  'Fees & Commission Guide', 'Access and Manage Your Account'),
            ],
          ),
        ),
      ),
    );
  }

  Widget expansionTile(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.hint.withOpacity(0.1),
        collapsedBackgroundColor: AppColors.hint.withOpacity(0.1),
        title: EraText(
          text: title,
          color: AppColors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        children: [
          ListTile(
            title: EraText(
              text: content,
              fontSize: 20.sp,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
