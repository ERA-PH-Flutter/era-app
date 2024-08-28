import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/carousel_models.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/widgets/app_divider.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/carousel/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/haraya.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/projects_controller.dart';

class ProjectMain extends GetView<ProjectsController> {
  const ProjectMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Column(
          children: [
            Column(
              children: ProjectsModels2.projects1.map((project) {
                return projectMainContainer(project);
              }).toList(),
            ),
          ],
        )),
      ),
    );
  }

  Widget projectMainContainer(ProjectsModels2 project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDivider(),

        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.header - 8.w),
          child: TextListing.projectTitle(
              EraTheme.header, FontWeight.w600, AppColors.blue),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.header - 8.w),
          child: TextListing.projectSubtitle(
              EraTheme.subHeader, FontWeight.w500, AppColors.black),
        ),

        SizedBox(height: 20.h),
        ProjectDivider(textImage: ProjectTextImageModels.textImageModels),
        SizedBox(height: 20.h),
        CarouselSliderWidget(images: CarouselModels.carouselModels),
        SizedBox(height: 20.h),
        projectContent1(project),
        SizedBox(height: 20.h),
        // //buttons
        Button(
            text: 'VIEW MORE',
            onTap: () {
              Get.toNamed("/haraya");
            },
            bgColor: AppColors.blue,
            borderRadius: BorderRadius.circular(30),
            height: 40.h,
            width: 240.w),
        SizedBox(height: 80.h),
        ProjectDivider(
            textImage: ProjectTextImageModels.textImageModels2,
            height: 150.h,
            width: 430.w,
            text: ' '),
        //temporary carousel
        CarouselSliderWidget(
            images: CarouselModels.layaCarouselImages,
            color: AppColors.carouselBgColor),
        SizedBox(height: 20.h),
        projectContent2(project),
        SizedBox(height: 60.h),
        Button(
          text: 'VIEW MORE',
          onTap: () {
            Get.toNamed("/laya");
          },
          bgColor: AppColors.blue,
          borderRadius: BorderRadius.circular(30),
          height: 40.h,
          width: 240.w,
        ),
        SizedBox(height: 80.h),
        ProjectDivider(
          textImage: ProjectTextImageModels.textImageModels3,
          height: 200.h,
          width: Get.width,
        ),
        SizedBox(height: 20.h),
        CarouselSliderWidget(
            images: CarouselModels.aureliaCarouselImages,
            color: AppColors.carouselBgColor),
        SizedBox(height: 30.h),
        projectContent3(project),
        SizedBox(height: 20.h),
        Button(
          text: 'VIEW MORE',
          onTap: () {
            Get.toNamed('/aurelia');
          },
          bgColor: AppColors.blue,
          borderRadius: BorderRadius.circular(30),
          height: 40.h,
          width: 240.w,
        ),
        SizedBox(height: 50.h),
      ],
    );
  }

  Widget projectContent1(ProjectsModels2 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HarayaProject.paddingTextTitle(
            project.text1,
            EraTheme.header - 3.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            0,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            project.text2,
            EraTheme.paragraph,
            FontWeight.w500,
            AppColors.black,
            0,
          ),
        ],
      ),
    );
  }

  Widget projectContent2(ProjectsModels2 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HarayaProject.paddingText(
            project.text3,
            EraTheme.header - 3.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            0,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            project.text4,
            EraTheme.paragraph,
            FontWeight.w500,
            AppColors.black,
            0,
          ),
        ],
      ),
    );
  }

  Widget projectContent3(ProjectsModels2 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.0.h),
      child: Column(
        children: [
          HarayaProject.paddingTextTitle(
            project.text5,
            EraTheme.header - 3.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            0,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            project.text6,
            EraTheme.paragraph,
            FontWeight.w500,
            AppColors.black,
            0,
          ),
        ],
      ),
    );
  }
}
