import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/carousel_models.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/carousel/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/haraya.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/widgets/custom_appbar.dart';
import '../../forms/contacts/controllers/contacts_controller.dart';
import '../../forms/contacts/pages/findus.dart';
import '../../forms/contacts/pages/inquiry.dart';
import '../controllers/projects_controller.dart';

class AureliaProject extends GetView<ProjectsController> {
  const AureliaProject({super.key});

  @override
  Widget build(BuildContext context) {
    ContactusController contactusController = Get.put(ContactusController());

    return Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: ProjectsModels1.aureliaProjects.map((aureliaProjects) {
              return projectContainer(aureliaProjects);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget projectContainer(ProjectsModels1 aureliaProjects) {
    return Column(
      children: [
        Image.asset(
          aureliaProjects.heroImage!,
          fit: BoxFit.cover,
          height: 250.h,
          width: Get.width,
        ),
        SizedBox(height: 30.h),
        ProjectDivider(
          textImage: ProjectTextImageModels.textImageModels3,
          height: 150.h,
          width: 430.w,
        ),
        SizedBox(height: 30.h),
        CarouselSliderWidget(
            images: CarouselModels.aureliaCarouselImages,
            color: AppColors.carouselBgColor),
        SizedBox(height: 30.h),
        projectContent1(aureliaProjects),
        SizedBox(height: 30.h),
        locationLaya(aureliaProjects),
        SizedBox(height: 40.h),
        discoverOurSpaces(
          aureliaProjects,
        ),
        SizedBox(height: 10.h),
        SizedBox(height: 15.h),
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

  Widget projectContent1(ProjectsModels1 aureliaProjects) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            aureliaProjects.image1!,
            width: Get.width,
          ),
          SizedBox(height: 30.h),
          HarayaProject.paddingTextTitle(
            aureliaProjects.text1!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            20,
          ),
          HarayaProject.paddingTextTitle(
            aureliaProjects.text2!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            20,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            aureliaProjects.text3!,
            14.sp,
            FontWeight.w500,
            AppColors.black,
            20,
          ),
          SizedBox(height: 30.h),
          Image.asset(
            aureliaProjects.image2!,
            width: Get.width,
          ),
          SizedBox(height: 30.h),
          HarayaProject.paddingTextTitle(
            aureliaProjects.text4!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            20,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            aureliaProjects.text5!,
            14.sp,
            FontWeight.w500,
            AppColors.black,
            20,
          ),
        ],
      ),
    );
  }

  Widget locationLaya(ProjectsModels1 aureliaProjects) {
    return Column(
      children: [
        HarayaProject.paddingText(
          aureliaProjects.text10!,
          20.sp,
          FontWeight.bold,
          AppColors.kRedColor,
          20,
        ),
        SizedBox(height: 10.h),
        EraText(
          text: aureliaProjects.text11!,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        Image.asset(aureliaProjects.image3!),
      ],
    );
  }

  Widget discoverOurSpaces(ProjectsModels1 aureliaProjects) {
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
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            aureliaProjects.text6!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            45.sp,
          ),
          SizedBox(height: 15.h),
          HarayaProject.carouselSliderWidget2(
            CarouselModels.amenities,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            aureliaProjects.text7!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            45.sp,
          ),
          SizedBox(height: 15.h),
          HarayaProject.carouselSliderWidget2(
            CarouselModels.brDeluxe,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            aureliaProjects.text8!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            45.sp,
          ),
          SizedBox(height: 15.h),
          HarayaProject.carouselSliderWidget2(
            CarouselModels.brPremier,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            aureliaProjects.text9!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            45.sp,
          ),
          SizedBox(height: 15.h),
          HarayaProject.carouselSliderWidget2(
            CarouselModels.brSignature,
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
