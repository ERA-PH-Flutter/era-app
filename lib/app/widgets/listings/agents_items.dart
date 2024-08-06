import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgentsItems extends StatelessWidget {
  final RealEstateListing agentInfo;
  final Function()? onTap;
  const AgentsItems({super.key, required this.agentInfo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(top: 120.h, left: 60.w, right: 60.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
              border:
                  Border.all(color: AppColors.hint.withOpacity(0.5), width: 3),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              //     ListedBy(
              //   text: 'Listed By',
              //   image: agentInfo.agentImage,
              //   agentFirstName: agentInfo.agentFirstName,
              //   agentLastName: agentInfo.agentLastName,
              //   agentType: agentInfo.agents,
              // ),
              EraText(
                text: '${agentInfo.user.firstname} ${agentInfo.user.lastname}',
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
              EraText(
                text: '${agentInfo.user.role}',
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppEraAssets.whatsappIcon,
                    width: 30.w,
                    height: 30.h,
                  ),
                  SizedBox(width: 8.w),
                  EraText(
                    text: '${agentInfo.user.whatsApp}',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppEraAssets.emailIcon,
                    width: 30.w,
                    height: 30.h,
                  ),
                  SizedBox(width: 8.w),
                  EraText(
                    text: '${agentInfo.user.email}',
                    fontSize: 20.sp,
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
                  Get.toNamed('/agentDashBoard', arguments: agentInfo);
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
          top: 30.h,
          left: 115.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.w),
            child: Image.asset(
              '${agentInfo.user.image}',
              height: 150.h,
              width: 180.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
