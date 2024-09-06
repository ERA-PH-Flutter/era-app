import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../app/widgets/button.dart';
import '../../../../../app/widgets/custom_appbar.dart';
import 'contact_us.dart';

class JoinEra extends StatelessWidget {
  const JoinEra({super.key});

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
                    'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
                fit: BoxFit.cover,
                height: 250.h,
                width: Get.width,
              ),
              SizedBox(height: 15.h),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                child: EraText(
                    text: 'Join Us Today',
                    fontSize: EraTheme.header - 4.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kRedColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              _buildDescription(
                  'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.'),
              SizedBox(
                height: 20.h,
              ),
              _buildDescription(
                  'ERA Real Estate was founded on the principle of collaboration.'),
              _buildDescription(
                  'The idea that by working together and supporting one another, we can create a stronger, more knowledgeable community of real estate professionals who are better prepared serve your unique needs.'),
              SizedBox(
                height: 20.h,
              ),
              _buildDescription('Why Join Us?',
                  color: AppColors.blue,
                  fontSize: EraTheme.header - 4.sp,
                  fontWeight: FontWeight.w600),
              _buildDescription('•   Training & Development'),
              _buildDescription('•   Reputable developer properties'),
              _buildDescription('•   Favourable Commission Terms'),
              _buildDescription('•   Advanced Digital Platforms'),
              _buildDescription('•   Administrative Support'),
              _buildDescription('•   Access to our office spaces & facilities'),
              sb30(),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                width: Get.width,
                child: Button(
                  borderRadius: BorderRadius.circular(99),
                  onTap: () {
                    Get.toNamed(RouteString.createaccount);
                  },
                  height: 53.h,
                  width: Get.width,
                  text: "Get Started",
                  fontSize: EraTheme.paragraph,
                  bgColor: AppColors.kRedColor,
                ),
              ),
              sb50(),
            ],
          ),
        ),
      ),
    );
  }

  _buildDescription(text, {fontWeight, fontSize, color}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: Column(
        children: [
          EraText(
              text: text,
              maxLines: 50,
              fontSize: fontSize ?? EraTheme.paragraph,
              fontWeight: fontWeight ?? FontWeight.w500,
              color: color ?? AppColors.black),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
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
