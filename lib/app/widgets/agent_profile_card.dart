import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';

//ignore: must_be_immutable
class AgentProfileCard extends StatelessWidget {
  String? image;
  String? fname;
  String? lname;
  String? role;
  String? whatsApp;
  String? email;
  String? description;

  AgentProfileCard({
    super.key,
    this.image,
    this.fname,
    this.lname,
    this.role,
    this.whatsApp,
    this.email,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: AppColors.hint),
              child: CloudStorage().imageLoader(
                ref: image ?? '',
                width: 55.w,
                height: 55.w,
                //     fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: '$fname $lname',
                  fontSize: EraTheme.paragraph,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                EraText(
                  text: role ?? '',
                  fontSize: EraTheme.paragraph - 4.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                EraText(
                  text: "STATUS",
                  fontSize: 14.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
                // SizedBox(height: 5.h),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        EraText(
          text: "Profile Overview",
          fontSize: 18.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        EraText(
          text: description ?? '',
          fontSize: 15.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          maxLines: 3,
        ),
        sb10(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              whatsApp != null
                  ? AppEraAssets.whatsappIcon
                  : AppEraAssets.whatsappIcon,
              width: 40.w,
              height: 40.h,
            ),
            EraText(
              text: "$whatsApp",
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              lineHeight: 0.h,
            ),
          ],
        ),
        sb5(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              email != null ? AppEraAssets.emailIcon : AppEraAssets.emailIcon,
              width: 40.w,
              height: 40.h,
            ),
            EraText(
              text: "$email",
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              lineHeight: 0.h,
            ),
          ],
        ),
        sb5(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              color: AppColors.kRedColor,
              email != null ? AppEraAssets.marker : AppEraAssets.marker,
              width: 40.w,
              height: 40.h,
            ),
            EraText(
              text: "City Location",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              lineHeight: 0.h,
            ),
          ],
        ),
        sb10(),
        EraText(
          text: "ERA RANKING",
          fontSize: 14.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        Row(
          children: [
            EraText(
              text: "PRC LIC#",
              fontSize: 14.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: 10.w),
            EraText(
              text: "000000",
              fontSize: 14.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
