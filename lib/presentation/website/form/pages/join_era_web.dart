import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/terms_conditions/terms_condition.dart';
import 'package:eraphilippines/presentation/website/form/pages/about_us_web.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../app/widgets/button.dart';
import '../../../../../app/widgets/custom_appbar.dart';
import '../../terms_conditions_web/terms_condition_web.dart';
import '../controllers/form_web_controller.dart';

class JoinEraWeb extends GetView<FormWebController> {
  const JoinEraWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          SizedBox(height: 15.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                  textAlign: TextAlign.start,
                  text: 'Join Us Today!',
                  fontSize: EraTheme.headerWeb,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kRedColor),
              SizedBox(
                height: 30.h,
              ),
              _buildDescription(
                  'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.'),
              SizedBox(
                height: 20.h,
              ),
              _buildDescription(
                  'ERA Real Estate was founded on the principle of collaboration.'),
              _buildDescription(
                  'The idea that by working together and supporting one another, we can create a stronger, more knowledgeable community of real estate professionals who are better prepared to serve your unique needs.'),
              sb20(),
            ],
          ),
          // _buildDescription('Why Join Us?',
          //     color: AppColors.blue,
          //     fontSize: EraTheme.header - 4.sp,
          //     fontWeight: FontWeight.w600),
          // _buildDescription('•   Training & Development'),
          // _buildDescription('•   Reputable developer properties'),
          // _buildDescription('•   Favourable Commission Terms'),
          // _buildDescription('•   Advanced Digital Platforms'),
          // _buildDescription('•   Administrative Support'),
          // _buildDescription('•   Access to our office spaces & fa   cilities'),
          AboutUsWeb.joinUs(),
          sb50(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
            width: Get.width,
            child: Button(
              borderRadius: BorderRadius.circular(99),
              onTap: () {
                //   Get.toNamed(RouteString.TermsConditionWeb);
                TermsConditionWeb();
              },
              height: 53.h,
              width: Get.width / 2,
              text: "Get Started",
              fontSize: EraTheme.paragraphWeb,
              bgColor: AppColors.kRedColor,
            ),
          ),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'By continuing, you agree to our ',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: EraTheme.paragraphWeb - 10.sp,
                ),
                children: [
                  TextSpan(
                    text: 'Terms',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: EraTheme.paragraphWeb - 10.sp,
                    ),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: EraTheme.paragraphWeb - 10.sp,
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: EraTheme.paragraphWeb - 10.sp,
                    ),
                  ),
                ]),
          ),
          sb50(),
        ],
      ),
    );
  }

  _buildDescription(text, {fontWeight, fontSize, color}) {
    return EraText(
        textAlign: TextAlign.start,
        text: text,
        maxLines: 50,
        fontSize: fontSize ?? EraTheme.paragraphWeb,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.black);
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
