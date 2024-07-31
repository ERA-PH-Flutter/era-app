import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';

import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';

import 'package:eraphilippines/app/widgets/customenavigationbar.dart';

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

//https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Feramerch1.png?alt=media&token=07bcf1a1-9e8a-470d-9721-59687d0130af
// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Feramerch2.png?alt=media&token=848caa4a-49b2-4e37-9c92-af79a20356f6
// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Feramerch3.png?alt=media&token=060ac304-8202-46bf-89ef-6a6adc8f999b
// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Feramerch4.png?alt=media&token=f0cc3172-30a6-493f-9436-072772f5b36d
// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2FclickForMore.png?alt=media&token=3a8da7ac-8e75-41c1-803e-cf5bcd1d9814
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
              latestNewIcon('assets/icons/eramerch1.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/eramerch2.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/eramerch3.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/eramerch4.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/clickForMore.png', () {}),
            ],
          ),
        ),
      ],
    );
  }

// "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Fcompanynews1.jpg?alt=media&token=fa96fd08-46b2-4e03-b03f-d378ca943aee"
// "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Fcompanynews1.jpg?alt=media&token=fa96fd08-46b2-4e03-b03f-d378ca943aee"
// "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Fcompanynews1.jpg?alt=media&token=fa96fd08-46b2-4e03-b03f-d378ca943aee"
// "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Fcompanynews1.jpg?alt=media&token=fa96fd08-46b2-4e03-b03f-d378ca943aee"
// 'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2FclickForMore.png?alt=media&token=3a8da7ac-8e75-41c1-803e-cf5bcd1d9814'
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
              latestNewIcon('assets/images/companynews1.jpg', () {
                Get.to(() => CompanyNews());
              }),
              SizedBox(width: 10.w),
              latestNewIcon('assets/images/companynews1.jpg', () {
                Get.to(() => CompanyNews());
              }),
              SizedBox(width: 10.w),
              latestNewIcon('assets/images/companynews1.jpg', () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/images/companynews1.jpg', () {}),
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

// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Fvideotrainings.png?alt=media&token=67a19f54-30ea-4335-9505-3e71a0342070
// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Flearningmaterials.png?alt=media&token=5fca7180-0f81-45e4-9bbd-ab2f961f496b
// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Fupcoming.png?alt=media&token=60053da0-309e-4fb5-87e9-3dc7bbcf339d'
// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2FclickForMore.png?alt=media&token=3a8da7ac-8e75-41c1-803e-cf5bcd1d9814'
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

//https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/agentdashboard%2Faddicon.png?alt=media&token=deeb56a5-2756-4f6d-9fbd-5936fd59d1b2
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
    //   child:  Image.asset(
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