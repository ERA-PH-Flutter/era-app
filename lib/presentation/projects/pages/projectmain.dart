import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/carousel_models.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/widgets/app_divider.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:eraphilippines/presentation/projects/pages/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProjectMain extends StatelessWidget {
  const ProjectMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
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
        TextListing.projectTitle(25.sp, FontWeight.bold, AppColors.blue),
        SizedBox(height: 10.h),
        TextListing.projectSubtitle(18.sp, FontWeight.bold, AppColors.black),
        SizedBox(height: 20.h),
        ProjectDivider(textImage: ProjectTextImageModels.textImageModels),
        SizedBox(height: 20.h),
        // can add carousel new photos just go to lib/app/models/carousel_models.dart
        CarouselSliderWidget(images: CarouselModels.carouselModels),
        SizedBox(height: 20.h),
        projectContent1(project),
        SizedBox(height: 10.h),
        // //buttons
        Button(
            text: 'VIEW MORE',
            onTap: () {
              Get.toNamed('/project');
            },
            bgColor: AppColors.blue,
            borderRadius: BorderRadius.circular(30),
            height: 30.h,
            width: 130.w),
        // i suggest to add text already on the picture, because the picture im using has white background so when im gonna put the text it will have a gap
        SizedBox(height: 20.h),
        ProjectDivider(
            textImage: ProjectTextImageModels.textImageModels2,
            height: 150.h,
            width: 500,
            text: ' '),
        //temporary carousel
        CarouselSliderWidget(
            images: CarouselModels.carouselModels,
            color: AppColors.carouselBgColor1),
        SizedBox(height: 25.h),
        projectContent2(project),
        SizedBox(height: 10.h),
        Button(
            text: 'VIEW MORE',
            onTap: () {
              Get.toNamed('/project');
            },
            bgColor: AppColors.blue,
            borderRadius: BorderRadius.circular(30),
            height: 30.h,
            width: 130.w),
        SizedBox(height: 20.h),
        ProjectDivider(textImage: ProjectTextImageModels.textImageModels3),
        SizedBox(height: 20.h),
        CarouselSliderWidget(
            images: CarouselModels.carouselModels,
            color: AppColors.carouselBgColor),
        SizedBox(height: 30.h),
        projectContent3(project),
        SizedBox(height: 20.h),
        Button(
            text: 'VIEW MORE',
            onTap: () {
              Get.toNamed('/project');
            },
            bgColor: AppColors.blue,
            borderRadius: BorderRadius.circular(30),
            height: 30.h,
            width: 130.w),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget projectContent1(ProjectsModels2 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProjectPage.paddingText(
            project.text1,
            20,
            FontWeight.bold,
            AppColors.kRedColor,
            0,
          ),
          SizedBox(height: 20.h),
          ProjectPage.paddingText(
            project.text2,
            14,
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
          ProjectPage.paddingText(
            project.text3,
            20,
            FontWeight.bold,
            AppColors.kRedColor,
            0,
          ),
          SizedBox(height: 20.h),
          ProjectPage.paddingText(
            project.text4,
            14,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectPage.paddingText(
            project.text5,
            20,
            FontWeight.bold,
            AppColors.kRedColor,
            0,
          ),
          SizedBox(height: 20.h),
          ProjectPage.paddingText(
            project.text6,
            14,
            FontWeight.w500,
            AppColors.black,
            0,
          ),
        ],
      ),
    );
  }
}