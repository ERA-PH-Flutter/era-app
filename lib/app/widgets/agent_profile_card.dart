import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';

class AgentProfileCard extends StatelessWidget {
  final RealEstateListing listing;

  const AgentProfileCard({super.key, required this.listing});

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
              child: Image.network(
                listing.user.image ?? '',
                width: 55.w,
                height: 55.w,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: '${listing.user.firstname} ${listing.user.lastname}',
                  fontSize: EraTheme.paragraph,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                EraText(
                  text: listing.user.role ?? '',
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
          text:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non mauris congue, eleifend orci ac, eleifend est. Donec varius arcu magna, vel sagittis ex condimentum scelerisque. Fusce efficitur nisi ut mauris vulputate faucibus. Nullam hendrerit, lacus id interdum tempus.',
          fontSize: 15.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          maxLines: 3,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              listing.user.whatsApp != null
                  ? AppEraAssets.whatsappIcon
                  : AppEraAssets.whatsappIcon,
              width: 45.w,
              height: 45.h,
            ),
            EraText(
              text: "${listing.user.whatsApp}",
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              lineHeight: 0.h,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              listing.user.email != null
                  ? AppEraAssets.emailIcon
                  : AppEraAssets.emailIcon,
              width: 45.w,
              height: 45.h,
            ),
            EraText(
              text: "${listing.user.email}",
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              lineHeight: 0.h,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              listing.user.email != null
                  ? AppEraAssets.emailIcon
                  : AppEraAssets.emailIcon,
              width: 45.w,
              height: 45.h,
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
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Button(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: 150.w,
            height: 35.h,
            text: 'EDIT',
            bgColor: AppColors.blue,
            borderRadius: BorderRadius.circular(30),
          ),
          Button(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: 150.w,
            height: 35.h,
            text: 'DELETE',
            bgColor: AppColors.kRedColor,
            borderRadius: BorderRadius.circular(30),
          ),
        ])
      ],
    );
  }
}
