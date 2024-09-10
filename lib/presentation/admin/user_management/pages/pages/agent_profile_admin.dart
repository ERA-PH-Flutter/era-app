import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/agent_profile_card.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgentProfileAdmin extends GetView<AgentAdminController> {
  AgentProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final RealEstateListing? agentData =
        controller.agentListings ?? Get.arguments;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Side (Agent Profile, Favorites, Latest News)
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EraText(
                          text: 'AGENT PROFILE',
                          color: AppColors.kRedColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        AgentProfileCard(
                          image: agentData?.image,
                          fname: agentData?.user.firstname,
                          lname: agentData?.user.lastname,
                          role: agentData?.user.role,
                          whatsApp: agentData?.user.whatsApp,
                          email: agentData?.user.email,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  FavoritesSection(),
                  SizedBox(height: 20.h),
                  latestNews(),
                ],
              ),
            ),

            // Right Side (Property Status, Listings, Pagination)
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(EraTheme.paddingWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EraText(
                      text: 'PROPERTY STATUS',
                      color: AppColors.kRedColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 200.h,
                      child: EraText(
                        text: 'NO   AVAILABLE',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                    // Property Status Section
                    //   PropertyStatusSection(),

                    // Listings Section
                    // Expanded(
                    //child: ListingsGrid(),
                    //    ),

                    // Pagination Section
                    //  PaginationSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget FavoritesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      EraText(
        text: 'FAVORITES',
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.kRedColor,
      ),
      SizedBox(
        height: 200.h,
        child: EraText(
          text: 'NO LISTINGS AVAILABLE',
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
    ],
  );
}

Widget latestNews() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      EraText(
        text: 'LATEST NEWS',
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.kRedColor,
      ),
      SizedBox(
        height: 200.h,
        child: EraText(
          text: 'NO NEWS YET',
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
    ],
  );
}
