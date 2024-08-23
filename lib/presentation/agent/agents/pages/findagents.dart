
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/listings/agentlistview.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class FindAgents extends GetView<AgentsController> {
  const FindAgents({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:EraTheme.paddingWidth,vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: 'HAVE AN AGENT ALREADY?',
                fontSize: EraTheme.subHeader,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
              SizedBox(height: 5.h),
              TextformfieldWidget(
                controller: controller.agentName,
                hintText: 'Type Name Here',
                maxLines: 1,
                hintstlye: TextStyle(color: AppColors.hint, fontSize: EraTheme.paragraph + 2.sp),
              ),
              SizedBox(height: 10.h),
              EraText(
                text: 'SEARCH VIA AGENT ID',
                fontSize: EraTheme.subHeader,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
              SizedBox(height: 5.h),
              TextformfieldWidget(
                controller: controller.agentId,
                hintText: 'Enter Agent ID',
                maxLines: 1,
                hintstlye: TextStyle(color: AppColors.hint, fontSize: EraTheme.paragraph + 2.sp),
              ),
              SizedBox(height: 10.h),
              EraText(
                text: 'LOOKING FOR ONE?',
                fontSize: EraTheme.subHeader,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
              SizedBox(height: 5.h),
              TextformfieldWidget(
                controller: controller.agentLocation,
                hintText: 'Type Your Location',
                maxLines: 1,
                hintstlye: TextStyle(color: AppColors.hint, fontSize: EraTheme.paragraph + 2.sp),
              ),
              SizedBox(height: 20.h),
              Button(
                text: 'SEARCH',
                fontSize: 25.sp,
                onTap: () {
                  controller.search();
                },
                bgColor: AppColors.kRedColor,
                height: 48.h,
                width: 500.w,
                fontWeight: FontWeight.w600,
                margin: EdgeInsets.symmetric(horizontal: 0),
              ),
              SizedBox(height: 25.h),
              Obx(()=>switch(controller.agentState.value){
                AgentsState.loading => _loading(),
                AgentsState.loaded => _loaded(),
                AgentsState.error => _error(),
                AgentsState.empty => _empty(),
                AgentsState.blank => _blank(),
              })
            ],
          ),
        ),
      ),
    );
  }
  _blank(){
    return Container();
  }
  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  _error() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 100.h,),
          EraText(
            fontSize: EraTheme.paragraph,
            text: "Something went Wrong!",
            color: Colors.black,
          ),
        ],
      ),
    );
  }
  _empty(){
    return Center(
      child: Column(
        children: [
          SizedBox(height: 100.h,),
          EraText(
            fontSize: EraTheme.paragraph,
            text: "No User Found!",
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  _loaded(){
    return Column(
      children: [
        Obx(()=>EraText(
          text: controller.resultText.value,
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.blue,
        )),
        Obx(()=> AgentListView(agentsModels: controller.results.value),)
      ]
    );
  }
}
