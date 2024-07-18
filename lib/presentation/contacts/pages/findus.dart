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
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: 'Where to Find Us',
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/marker2.png',
                width: 38.w,
                height: 40.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              EraText(
                text:
                    'Riverside Road corner Bridgetowne\nBlvd., Bridgetowne Destination\nEstate, E. Rodriguez Ave., Brgy.\nRosario, Pasig City',
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
                'assets/icons/mail.png',
                width: 38.w,
                height: 40.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              EraText(
                text: 'sales@harayaresodemces.com',
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
                'assets/icons/whatsapp.png',
                width: 38.w,
                height: 40.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              EraText(
                text: '0917 5-HARAYA (427292)',
                fontSize: 14.sp,
                color: AppColors.black,
                maxLines: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
