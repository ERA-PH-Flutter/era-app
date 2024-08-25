import 'package:eraphilippines/app/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';

class AgentProfileCard extends StatelessWidget {
  final RealEstateListing listing;

  const AgentProfileCard({Key? key, required this.listing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListedBy(
          text: '',
          image: listing.user.image ?? '',
          agentFirstName: listing.user.firstname ?? '',
          agentLastName: listing.user.lastname ?? '',
          agentType: listing.user.role ?? '',
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w, top: 20.h),
          child: EraText(
            text: "Profile Overview",
            fontSize: 18.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.w, top: 10.h, right: 25.w),
          child: EraText(
            text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non mauris congue, eleifend orci ac, eleifend est. Donec varius arcu magna, vel sagittis ex condimentum scelerisque. Fusce efficitur nisi ut mauris vulputate faucibus. Nullam hendrerit, lacus id interdum tempus.',
            fontSize: 15.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.w, top: 10.h),
          child: Row(
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
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Row(
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
        ),
      ],
    );
  }
}
