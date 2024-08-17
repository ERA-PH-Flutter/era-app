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
  AgentsItems({super.key, required this.agentInfo, this.onTap});
  var selected = false.obs;

  void toggleSelected() {
    selected.value = !selected.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleSelected();
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              height: selected.value ? 260.h : 250.h,
              width: 500.w,
              // margin: EdgeInsets.only(top: 120.h, left: 60.w, right: 60.w),
              margin: selected.value
                  ? EdgeInsets.only(top: 320.h, left: 40.w, right: 40.w)
                  : EdgeInsets.only(top: 200.h, left: 40.w, right: 40.w),

              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.hint.withOpacity(0.5), width: 3.w),
                  borderRadius: BorderRadius.circular(8)),
              child: selected.value
                  ? Column(
                      children: [
                        SizedBox(height: 55.h),
                        EraText(
                          text:
                              '${agentInfo.user.firstname} ${agentInfo.user.lastname}',
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue,
                          lineHeight: 1.0,
                        ),
                        EraText(
                          text: '${agentInfo.user.role}',
                          fontSize: 15.sp,
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
                              fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Button(
                          text: 'VIEW LISTINGS',
                          fontSize: 13.sp,
                          onTap: () {
                            Get.toNamed('/agentDashBoard',
                                arguments: agentInfo);
                          },
                          bgColor: AppColors.kRedColor,
                          height: 30.h,
                          width: 200.w,
                          fontWeight: FontWeight.w400,
                          margin: EdgeInsets.symmetric(horizontal: 35),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: 55.h),
                        EraText(
                          text:
                              '${agentInfo.user.firstname} ${agentInfo.user.lastname}',
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue,
                          lineHeight: 1.0,
                        ),
                        EraText(
                          text: '${agentInfo.user.role}',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
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
                              fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Button(
                          text: 'VIEW LISTINGS',
                          fontSize: 13.sp,
                          onTap: () {
                            Get.toNamed('/agentDashBoard',
                                arguments: agentInfo);
                          },
                          bgColor: AppColors.kRedColor,
                          height: 30.h,
                          width: 200.w,
                          fontWeight: FontWeight.w400,
                          margin: EdgeInsets.symmetric(horizontal: 35),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    ),
            ),
          ),
          Obx(
            () => selected.value
                ? Positioned(
                    top: 50.h,
                    left: 50.w,
                    right: 50.w,
                    bottom: 200.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.w),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                        height: 200.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              '${agentInfo.user.image}',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    top: 50.h,
                    left: 100.w,
                    right: 100.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.w),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: 200.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              '${agentInfo.user.image}',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
