import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/carousel_models.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:eraphilippines/presentation/contacts/pages/findus.dart';
import 'package:eraphilippines/presentation/contacts/pages/inquiry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: ProjectsModels1.projects.map((project) {
              return projectContainer(project);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget projectContainer(ProjectsModels1 project) {
    return Column(
      children: [
        Image.asset(project.heroImage),
        SizedBox(height: 15.h),
        ProjectDivider(textImage: ProjectTextImageModels.textImageModels),
        SizedBox(height: 15.h),
        CarouselSliderWidget(
          images: CarouselModels.carouselModels2,
        ),
        SizedBox(height: 30.h),
        projectContent1(project),
        SizedBox(height: 30.h),
        projectContent2(project),
        SizedBox(height: 50.h),
        projecContent3(project),
        projectContent4(project),
        Inquiry(),
        SizedBox(height: 40.h),
        FindUs(),
      ],
    );
  }

  Widget projectContent1(ProjectsModels1 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.0.h),
      color: AppColors.hint.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          paddingText(
            project.text1,
            20,
            FontWeight.bold,
            AppColors.blue,
            15,
          ),
          paddingText(
            project.text2,
            18,
            FontWeight.bold,
            AppColors.kRedColor,
            20,
          ),
          SizedBox(height: 10.h),
          paddingText(
            project.text3,
            14,
            FontWeight.w500,
            AppColors.black,
            20,
          ),
          SizedBox(height: 10.h),
          Image.asset(
            project.image1,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget projectContent2(ProjectsModels1 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: project.text4,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 20.h),
          Image.asset(
            project.image2,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: project.text5,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: project.text6,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 10.h),
          Image.asset(
            project.image3,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: project.text7,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
        ],
      ),
    );
  }

  Widget projecContent3(ProjectsModels1 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          EraText(
            text: project.text8,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 10.h),
          EraText(
            text: project.text9,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          SizedBox(height: 20.h),
          Image.asset(project.image4),
          SizedBox(height: 20.h),
          EraText(
            text: project.text10,
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 10.h),
          EraText(
            text: project.text11,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
          SizedBox(height: 20.h),
          Image.asset(project.image5),
          SizedBox(height: 30.h),
          Image.asset(project.image6),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget projectContent4(ProjectsModels1 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: project.text12,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          SizedBox(height: 10.h),
          EraText(
            text: project.text13,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
          SizedBox(height: 20.h),
          Image.asset(project.image7),
          SizedBox(height: 10.h),
          EraText(
            text: project.text14,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: project.text15,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
          SizedBox(height: 20.h),
          Image.asset(project.image8),
          SizedBox(height: 10.h),
          EraText(
            text: project.text16,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: project.text17,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
        ],
      ),
    );
  }

  static Widget paddingText(String text, double fontSize, FontWeight fontWeight,
      Color color, double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding.w,
      ),
      child: EraText(
        text: text,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
        maxLines: 50,
      ),
    );
  }
}