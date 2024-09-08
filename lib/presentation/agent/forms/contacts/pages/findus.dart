import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/constants/sized_box.dart';
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
                'Visit ERA Philippines to learn more about this project.',
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.only(
              left: 8.w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppEraAssets.markerIcon,
                  width: 50.w,
                  height: 50.h,
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
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              launchUrl(controller.whatsappUrl);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.subtle,
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12.w, right: 12.w, top: 12.h, bottom: 12.h),
                    child: Image.asset(
                      AppEraAssets.whatsappIcon,
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                  Container(
                    width: 250.w,
                    child: EraText(
                      text: '+639177710572',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          sb10(),
          GestureDetector(
            onTap: () {
              launchUrl(controller.emailUrl);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.subtle,
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 12.w, right: 12.w, top: 12.h, bottom: 12.h),
                    child: Image.asset(
                      color: AppColors.kRedColor,
                      AppEraAssets.emailIcon,
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                  Container(
                    width: 250.w,
                    child: EraText(
                      text: 'eraphilippines@gmail.com',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
