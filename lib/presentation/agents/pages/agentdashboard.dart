import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/findingproperties.dart';
import 'package:eraphilippines/app/widgets/listedBy_widget.dart';
import 'package:eraphilippines/presentation/companynews/pages/companynews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Agentinfo extends StatelessWidget {
  final RealEstateListing listing;
  const Agentinfo({
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
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: 'MY PROFILE',
                  color: AppColors.blue,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
                agentInfo(),
                SizedBox(height: 25.h),
                myListings(),
                SizedBox(height: 25.h),
                myTrainings(),
                SizedBox(height: 25.h),
                findAgentsandOffices(),
                SizedBox(height: 25.h),
                latestNews(),
                SizedBox(height: 25.h),
                eraMerch(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget eraMerch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'ERA MERCH',
          color: AppColors.kRedColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              latestNewIcon("assets/icons/eramerch1.png", () {}),
              SizedBox(width: 10.w),
              latestNewIcon("assets/icons/eramerch2.png", () {}),
              SizedBox(width: 10.w),
              latestNewIcon("assets/icons/eramerch3.png", () {}),
              SizedBox(width: 10.w),
              latestNewIcon("assets/icons/eramerch4.png", () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/clickForMore.png', () {}),
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
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              latestNewIcon("assets/images/companynews1.jpg", () {
                Get.to(() => CompanyNews());
              }),
              SizedBox(width: 10.w),
              latestNewIcon("assets/images/companynews1.jpg", () {
                Get.to(() => CompanyNews());
              }),
              SizedBox(width: 10.w),
              latestNewIcon("assets/images/companynews1.jpg", () {}),
              SizedBox(width: 10.w),
              latestNewIcon("assets/images/companynews1.jpg", () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/clickForMore.png', () {}),
            ],
          ),
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
              iconAgents(listing.agentImage, () {}),
              iconAgents(listing.agentImage, () {}),
              iconAgents(listing.agentImage, () {}),
              iconAgents(listing.agentImage, () {}),
              iconAgents('assets/icons/clickForMore.png', () {}),
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
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              trainingIcon('assets/icons/videotrainings.png', () {}),
              trainingIcon('assets/icons/learningmaterials.png', () {}),
              trainingIcon('assets/icons/upcoming.png', () {}),
              trainingIcon('assets/icons/clickForMore.png', () {})
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
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Image.asset(
                'assets/icons/addicon.png',
                height: 110.h,
                width: 110.w,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget agentInfo() {
    return Row(
      children: [
        Image.asset(
          listing.agentImage,
          width: 100.w,
          height: 110.h,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.w, left: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              agentText(listing.agentFirstName + ' ' + listing.agentLastName,
                  AppColors.blue, 18.sp, FontWeight.bold, 1.2),
              agentText(
                  listing.agents, AppColors.black, 12.sp, FontWeight.w400, 0.9),
              agentContact(listing.whatsappIcon, listing.whatsapp),
              agentContact(listing.emailIcon, listing.email),
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

  Widget agentText(String text, Color color, double fontSize,
      FontWeight fontWeight, double lineHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: EraText(
        text: text,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        lineHeight: lineHeight,
      ),
    );
  }

  Widget agentContact(String iconPath, String text) {
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

Widget iconAgents(String assetPath, Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Image.asset(
      assetPath,
      height: 100.h,
      width: 100.w,
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

    // child: ClipRRect(
    //   borderRadius: BorderRadius.circular(30),
    //   child: Image.asset(
    //     assetPath,
    //     height: 100.h,
    //     width: 100.w,
    //   ),
    // ),
  );
}
       // SizedBox(height: 15.h),
                // ListedBy.agentListing(
                //   listing.agentImage,
                //   listing.agentFirstName,
                //   listing.agentLastName,
                //   listing.agents,
                //   listing.whatsapp,
                //   listing.whatsappIcon,
                //   l fontSize: 20.sp,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: FindingProperties(
                //     listingModels: RealEstateListing.listingsModels,
                //   ),
                // ),isting.email,
                //   listing.emailIcon,
                // ),
                // SizedBox(height: 15.h),
                // Center(
                //   child: EraText(
                //     text: 'LISTED PROPERTIES',
                //     color: AppColors.kRedColor,
                //   