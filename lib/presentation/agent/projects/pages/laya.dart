import 'package:carousel_slider_plus/carousel_options.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/carousel_models.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/carousel/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:eraphilippines/presentation/agent/contacts/controllers/contacts_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/haraya.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../contacts/pages/findus.dart';
import '../../contacts/pages/inquiry.dart';
import '../controllers/projects_controller.dart';

class LayaProject extends GetView<ProjectsController> {
  const LayaProject({super.key});

  @override
  Widget build(BuildContext context) {
    ContactusController contactusController = Get.put(ContactusController());

    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: ProjectsModels1.layaprojects.map((layaprojects) {
              return projectContainer(layaprojects);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget projectContainer(ProjectsModels1 layaprojects) {
    return Column(
      children: [
        Image.asset(
          layaprojects.heroImage ?? "",
          fit: BoxFit.cover,
          height: 250.h,
          width: Get.width,
        ),
        SizedBox(height: 30.h),
        ProjectDivider(
          textImage: ProjectTextImageModels.textImageModels2,
          height: 150.h,
          width: 430.w,
        ),
        SizedBox(height: 30.h),
        CarouselSliderWidget(
            images: CarouselModels.layaCarouselImages,
            color: AppColors.carouselBgColor),
        SizedBox(height: 30.h),
        //virtual
        SizedBox(
          height: 400.h,
          child: GestureDetector(
            child: WebViewWidget(
              controller: controller.webviews[0],
            ),
          ),
        ),

        SizedBox(width: 20),

        SizedBox(height: 30.h),

        projectContent1(layaprojects),
        SizedBox(height: 30.h),
//location
        locationLaya(layaprojects),
        SizedBox(height: 40.h),

        HarayaProject.paddingTextTitle(
          'Outdoor Amenities',
          18.sp,
          FontWeight.bold,
          AppColors.kRedColor,
          20,
        ),
        SizedBox(height: 20.h),
        CarouselSliderWidget(
          images: CarouselModels.layaOutdoorImages,
          color: AppColors.carouselBgColor,
        ),
        // carouselSliderWidget2(
        //   CarouselModels.layaOutdoorImages,
        // ),
        SizedBox(height: 40.h),

        HarayaProject.paddingTextTitle(
          'Indoor Amenities',
          18.sp,
          FontWeight.bold,
          AppColors.kRedColor,
          20,
        ),
        SizedBox(height: 20.h),

        CarouselSliderWidget(
          images: CarouselModels.layaIndoorImages,
          color: AppColors.carouselBgColor,
        ),
        SizedBox(height: 40.h),

        discoverOurSpaces(
          layaprojects,
        ),
        SizedBox(
          height: 400.h,
          child: GestureDetector(
            child: WebViewWidget(
              controller: controller.webviews[1],
            ),
          ),
        ),

        SizedBox(height: 30.h),
        Inquiry(),
        SizedBox(height: 40.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: FindUs(),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget projectContent1(ProjectsModels1 layaprojects) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            layaprojects.image1!,
            width: Get.width,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            layaprojects.text1!,
            14.sp,
            FontWeight.w500,
            AppColors.black,
            20,
          ),
          SizedBox(height: 30.h),
          HarayaProject.paddingTextTitle(
            layaprojects.text2!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            20,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            layaprojects.text3!,
            14.sp,
            FontWeight.w500,
            AppColors.black,
            20,
          ),
          SizedBox(height: 20.h),
          Image.asset(
            layaprojects.image2!,
            width: Get.width,
          ),
        ],
      ),
    );
  }

  Widget locationLaya(ProjectsModels1 layaprojects) {
    return Column(
      children: [
        HarayaProject.paddingText(
          layaprojects.text11!,
          20.sp,
          FontWeight.bold,
          AppColors.kRedColor,
          20,
        ),
        SizedBox(height: 10.h),
        EraText(
          text: layaprojects.text12!,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        Image.asset(layaprojects.image3!),
      ],
    );
  }

  Widget discoverOurSpaces(ProjectsModels1 layaprojects) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 15.0.h),
      color: AppColors.hint.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HarayaProject.paddingText(
            'Discover Our Spaces',
            20.sp,
            FontWeight.bold,
            AppColors.blue,
            20,
          ),
          SizedBox(height: 10.h),

          HarayaProject.paddingText(
            layaprojects.text4!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            45.sp,
          ),
          SizedBox(height: 20.h),
          HarayaProject.carouselSliderWidget2(
            CarouselModels.studioImages,
          ),
          SizedBox(height: 15.h),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            HarayaProject.infoTile(AppEraAssets.floorArea, layaprojects.text6!),
          ]),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            layaprojects.text5!,
            14.sp,
            FontWeight.w500,
            AppColors.black,
            45.sp,
          ),
          SizedBox(height: 40.h),
          //one bedroom
          HarayaProject.paddingText(
            layaprojects.text7!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            45.sp,
          ),
          SizedBox(height: 20.h),
          HarayaProject.carouselSliderWidget2(
            CarouselModels.bedRooms,
          ),
          SizedBox(height: 15.h),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            HarayaProject.infoTile(AppEraAssets.floorArea, layaprojects.text9!),
            HarayaProject.infoTile(
                AppEraAssets.loggiaSize, layaprojects.text10!),
          ]),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            layaprojects.text8!,
            14.sp,
            FontWeight.w500,
            AppColors.black,
            45.sp,
          ),
          SizedBox(height: 40.h),

          HarayaProject.paddingText(
            layaprojects.text13!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            45.sp,
          ),
          SizedBox(height: 20.h),
          HarayaProject.carouselSliderWidget2(
            CarouselModels.twoBedRooms,
          ),
          SizedBox(height: 15.h),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            HarayaProject.infoTile(
                AppEraAssets.floorArea, layaprojects.text15!),
            HarayaProject.infoTile(
                AppEraAssets.loggiaSize, layaprojects.text16!),
          ]),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            layaprojects.text14!,
            14.sp,
            FontWeight.w500,
            AppColors.black,
            45.sp,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
