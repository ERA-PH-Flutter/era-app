import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/agents_models.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgentsInfo extends StatelessWidget {
  final AgentsModels agentInfo;
  const AgentsInfo({super.key, required this.agentInfo});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(top: 50.h, left: 50.w, right: 50.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
              border:
                  Border.all(color: AppColors.hint.withOpacity(0.5), width: 3),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              EraText(
                text: '${agentInfo.firstName} ${agentInfo.lastName}',
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
              EraText(
                text: agentInfo.type,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    agentInfo.whatsappIcon,
                    width: 30.w,
                    height: 30.h,
                  ),
                  SizedBox(width: 8.w),
                  EraText(
                    text: agentInfo.whatsapp,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    agentInfo.emailIcon,
                    width: 30.w,
                    height: 30.h,
                  ),
                  SizedBox(width: 8.w),
                  EraText(
                    text: agentInfo.email,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Button(
                text: 'VIEW LISTINGS',
                fontSize: 13.sp,
                onTap: () {
                  Get.toNamed("/agentprofile");
                },
                bgColor: AppColors.kRedColor,
                height: 30.h,
                width: 200.w,
                fontWeight: FontWeight.w400,
                margin: EdgeInsets.symmetric(horizontal: 35),
                borderRadius: BorderRadius.circular(20),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
        Positioned(
          top: -30.h,
          left: 130.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.w),
            child: Image.asset(
              agentInfo.image,
              height: 150.h,
              width: 150.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
