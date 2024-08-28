import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FindUs extends StatelessWidget {
  const FindUs({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: 'Visit Era Philippines to learn more about this project.',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 15.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppEraAssets.markerIcon,
                width: 38.w,
                height: 40.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              EraText(
                text:
                    '1212 Century Spire Bldg. Century City,\nKalayaan Ave. Makati City',
                fontSize: 14.sp,
                color: AppColors.black,
                maxLines: 2,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Image.asset(
                AppEraAssets.whatsappIcon,
                width: 38.w,
                height: 40.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              EraText(
                text: '+639177710572',
                fontSize: 14.sp,
                color: AppColors.black,
                maxLines: 4,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Image.asset(
                AppEraAssets.emailIcon,
                width: 38.w,
                height: 40.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: () {},
                child: EraText(
                  text: 'eraphilippines@gmail.com',
                  fontSize: 14.sp,
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
