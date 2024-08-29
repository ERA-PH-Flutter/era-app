import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/contacts_controller.dart';

class FindUs extends GetView<ContactusController> {
  String? title;

  FindUs({super.key, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: title ??
                'Visit Era Philippines to learn more about this project.',
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 20.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppEraAssets.markerIcon,
                width: 38.w,
                height: 45.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              EraText(
                text:
                    '1212 Century Spire Bldg. Century City,\nKalayaan Ave. Makati City',
                fontSize: 17.sp,
                color: AppColors.black,
                maxLines: 2,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () async {
              launchUrl(controller.whatsappUrl);
            },
            child: Row(
              children: [
                Image.asset(
                  AppEraAssets.whatsappIcon,
                  width: 38.w,
                  height: 45.h,
                ),
                SizedBox(
                  width: 5.w,
                ),
                EraText(
                  text: '+639177710572',
                  fontSize: 17.sp,
                  color: AppColors.black,
                  maxLines: 4,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Image.asset(
                AppEraAssets.emailIcon,
                width: 38.w,
                height: 45.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: () {},
                child: EraText(
                  text: 'eraphilippines@gmail.com',
                  fontSize: 17.sp,
                  color: AppColors.black,
                  maxLines: 4,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
