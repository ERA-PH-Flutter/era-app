import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/company/company_grid.dart';
import 'package:eraphilippines/app/widgets/listings/agentInfo-widget.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgentDashBoard extends GetView<AgentsController> {
  final RealEstateListing listing;
  const AgentDashBoard({
    super.key,
    required this.listing,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:EraTheme.paddingWidth,vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: 'MY DASHBOARD',
                  color: AppColors.blue,
                  fontSize: EraTheme.header,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 10.h),
                AgentInfoWidget.agentInformation(
                    '${listing.user.image}',
                    '${listing.user.firstname}',
                    '${listing.user.lastname}',
                    '${listing.user.whatsApp}',
                    '${listing.user.email}',
                    '${listing.user.role}'),
                SizedBox(height: 25.h),
                Button(
                  fontSize: EraTheme.paragraph - 2.sp,
                  width: Get.width - 100.w,
                  height: 43.h,
                  text: 'MORTGAGE CALCULATOR',
                  bgColor: AppColors.kRedColor,
                  onTap: () {
                    Get.toNamed("/mortageCalculator");
                  },
                ),
                SizedBox(height: 25.h),
                myListings(),
                SizedBox(height: 25.h),
                favorites(),
                SizedBox(height: 25.h),
                archivedListing(),
                SizedBox(height: 25.h),
                soldProperties(),
                SizedBox(height: 25.h),
                myTrainings(),
                SizedBox(height: 25.h),
                findAgentsandOffices(),
                SizedBox(height: 25.h),
                latestNews(),
                SizedBox(height: 25.h),
                // eraMerch(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget soldProperties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'SOLD PROPERTIES',
          color: AppColors.kRedColor,
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    "/soldP", arguments: listing,
                  );
                },
                child: Image.asset(
                  AppEraAssets.sold,
                  height: 110.h,
                  width: 110.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget archivedListing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'ARCHIVED LISTINGS',
          color: AppColors.kRedColor,
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed("/archived", arguments: listing);
                },
                child: Image.asset(
                  AppEraAssets.archived,
                  height: 110.h,
                  width: 110.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget favorites() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'FAVORITES',
          color: AppColors.kRedColor,
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed("/fav");
                },
                child: Image.asset(
                  AppEraAssets.fav,
                  height: 110.h,
                  width: 110.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget eraMerch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'ERA MERCH',
          color: AppColors.kRedColor,
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              latestNewIcon('assets/icons/eramerch1.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/eramerch2.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/eramerch3.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/eramerch4.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon(AppEraAssets.clickFM, () {}),
            ],
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
            color: AppColors.kRedColor,
            fontSize: EraTheme.header - 5.sp,
            fontWeight: FontWeight.w600),
        SizedBox(
          height: 10.h,
        ),
        CompanyGrid(companymodels: CompanyModels.companyNewsModels),
        SizedBox(
          height: 20.h,
        ),
        //direct to companynews page. can find it in lib/presentation/companynews/pages/companynews.dart
        Button(
          text: 'MORE NEWS',
          fontSize: 25.sp,
          onTap: () {
            Get.toNamed("/companynews");
          },
          bgColor: AppColors.blue,
          height: 50.h,
          width: 350.w,
          fontWeight: FontWeight.w500,
          borderRadius: BorderRadius.circular(10),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  Widget findAgentsandOffices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'FIND AGENTS AND OFFICES',
          color: AppColors.kRedColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              iconAgents('${listing.user.image}', () {},
                  '${listing.user.firstname} ${listing.user.lastname}'),
              iconAgents('${listing.user.image}', () {},
                  '${listing.user.firstname} ${listing.user.lastname}'),
              iconAgents(AppEraAssets.clickFM, () {
                Get.toNamed("/findagents");
              }, 'Find Agents'),
            ],
          ),
        ),
      ],
    );
  }

  Widget myTrainings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'MY TRAININGS',
          color: AppColors.kRedColor,
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              trainingIcon(AppEraAssets.videoT, () {}),
              trainingIcon(AppEraAssets.learningM, () {}),
              trainingIcon(AppEraAssets.upcoming, () {}),
              trainingIcon(AppEraAssets.clickFM, () {})
            ],
          ),
        ),
      ],
    );
  }

  Widget myListings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'MY LISTINGS',
          color: AppColors.kRedColor,
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    '/addListings',
                  );
                },
                child: Image.asset(
                  AppEraAssets.addIcon,
                  height: 110.h,
                  width: 110.w,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/agentMyListing', arguments: listing);
                },
                child: Image.asset(
                  AppEraAssets.manageListings,
                  height: 110.h,
                  width: 110.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget trainingIcon(String assetPath, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        assetPath,
        height: 110.h,
        width: 110.w,
      ),
    );
  }

  static Widget agentText(String text, Color color, double fontSize,
      FontWeight fontWeight, double lineHeight) {
    return EraText(
      text: text,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      lineHeight: lineHeight,
    );
  }

  static Widget agentContact(String iconPath, String text) {
    return Row(
      children: [
        Image.asset(iconPath, width: 35.w, height: 28.h),
        EraText(
          text: text,
          color: AppColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

Widget iconAgents(String assetPath, Function()? onTap, String name) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Image.asset(
          assetPath,
          height: 110.h,
          width: 110.w,
        ),
        EraText(
          text: name,
          color: AppColors.blue,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ],
    ),
  );
}

Widget latestNewIcon(String assetPath, Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.cover,
        ),
      ),
      height: 90.h,
      width: 90.w,
    ),
  );
}
