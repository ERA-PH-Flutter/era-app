import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/agents_models.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/agentBorder.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/findingproperties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Agentinfo extends StatelessWidget {
  final AgentsModels listing;

  const Agentinfo({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: EraText(
                  text: 'AGENT PROFILE',
                  color: AppColors.blue,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Stack(
                children: [
                  AgentBorder(
                    child: Column(
                      children: [
                        SizedBox(height: 60.h),
                        EraText(
                          text: '${listing.firstName} ${listing.lastName}',
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue,
                        ),
                        EraText(
                          text: listing.type,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              listing.whatsappIcon,
                              width: 30.w,
                              height: 30.h,
                            ),
                            SizedBox(width: 8.w),
                            EraText(
                              text: listing.whatsapp,
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
                              listing.emailIcon,
                              width: 30.w,
                              height: 30.h,
                            ),
                            SizedBox(width: 8.w),
                            EraText(
                              text: listing.email,
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 30.h,
                    left: 125.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.w),
                      child: Image.asset(
                        listing.image,
                        height: 150.h,
                        width: 160.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Center(
                child: EraText(
                  text: 'LISTED PROPERTIES',
                  color: AppColors.kRedColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FindingProperties(
                  listingModels: RealEstateListing.listingsModels,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
