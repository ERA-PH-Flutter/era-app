import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/agents_models.dart';
import 'package:eraphilippines/app/widgets/agentlistview.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FindAgents extends GetView<HomeController> {
  const FindAgents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: 'HAVE AN AGENT ALREADY?',
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
              SizedBox(height: 10.h),
              TextformfieldWidget(
                hintText: 'Type Name Here',
                maxLines: 1,
                hintstlye: TextStyle(color: AppColors.hint, fontSize: 20.sp),
              ),
              SizedBox(height: 10.h),
              EraText(
                text: 'LOOKING FOR ONE?',
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
              SizedBox(height: 10.h),
              TextformfieldWidget(
                hintText: 'Type Your Location',
                maxLines: 1,
                hintstlye: TextStyle(color: AppColors.hint, fontSize: 20.sp),
              ),
              SizedBox(height: 15.h),
              Button(
                text: 'SEARCH',
                fontSize: 25.sp,
                onTap: () {},
                bgColor: AppColors.kRedColor,
                height: 45.h,
                width: 500.w,
                fontWeight: FontWeight.w600,
                margin: EdgeInsets.symmetric(horizontal: 0),
              ),
              SizedBox(height: 25.h),
              EraText(
                text: 'OUR TOP AGENTS',
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
              AgentListView(agentsModels: AgentsModels.agentsModels),
            ],
          ),
        ),
      ),
    );
  }
}
