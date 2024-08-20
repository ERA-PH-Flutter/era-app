import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RosterGridview extends StatelessWidget {
  final List<RealEstateListing> listingModels;

  const RosterGridview({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: 50.h,
        left: 80.w,
        right: 80.w,
      ),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 430.h,
          crossAxisCount: 3,
          crossAxisSpacing: 40.w,
          mainAxisSpacing: 30.h),
      itemCount: listingModels.length,
      itemBuilder: (context, i) => Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.hint.withOpacity(0.5), width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListedBy(
              text: '',
              image: "${listingModels[i].user.image}",
              agentFirstName: "${listingModels[i].user.firstname}",
              agentLastName: "${listingModels[i].user.lastname}",
              agentType: "${listingModels[i].user.role}",
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
                    listingModels[i].user.whatsApp == null
                        ? AppEraAssets.whatsappIcon
                        : AppEraAssets.whatsappIcon,
                    width: 45.w,
                    height: 45.h,
                  ),
                  EraText(
                    text: "${listingModels[i].user.whatsApp}",
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
                    listingModels[i].user.email == null
                        ? AppEraAssets.emailIcon
                        : AppEraAssets.emailIcon,
                    width: 45.w,
                    height: 45.h,
                  ),
                  EraText(
                    text: "${listingModels[i].user.email}",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    lineHeight: 0.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 250.w),
              child: Button(
                width: 150.w,
                height: 35.h,
                fontSize: 15.sp,
                text: 'MESSAGE',
                bgColor: AppColors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
