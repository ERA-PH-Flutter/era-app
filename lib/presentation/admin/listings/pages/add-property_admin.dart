import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/add-agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../agents/controllers/agents_controller.dart';
//todo add text

class AddPropertyAdmin extends GetView<AgentAdminController> {
  const AddPropertyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.agentState.value) {
                AgentAdminState.loading => _loading(),
                AgentAdminState.loaded => _loaded(),
                AgentAdminState.error => _error(),
                AgentAdminState.empty => _empty()
              }),
        ),
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  _loaded() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          EraText(
            text: 'PROPERTY INFORMATION',
            color: AppColors.black,
            fontSize: 18.sp,
          ),
          EraText(
            text: 'CREATE LISTING',
            color: AppColors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddAgent.buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.fNameA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 2.5,
                      'First Name *',
                      60.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  AddAgent.buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.lNameA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 2.5,
                      'Last Name *',
                      60.h),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AddAgent.buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.phoneNA,
                    fontSize: 12.sp,
                    maxLines: 1,
                  ),
                  // Get.width / 3.8,
                  Get.width / 5 - 10.w,
                  'Phone Number *',
                  60.h),
              SizedBox(
                width: 20.w,
              ),
              AddAgent.buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.positionA,
                    fontSize: 12.sp,
                    maxLines: 1,
                  ),
                  Get.width / 5 - 10.w,
                  'Position *',
                  60.h),
              SizedBox(
                width: 20.w,
              ),
              AddAgent.buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.passwordA,
                    fontSize: 12.sp,
                    maxLines: 1,
                  ),
                  Get.width / 5 - 10.w,
                  'Password *',
                  60.h),
              SizedBox(
                width: 20.w,
              ),
              AddAgent.buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.confirmPA,
                    fontSize: 12.sp,
                    maxLines: 1,
                  ),
                  Get.width / 5 - 10.w,
                  'Confirm Password *',
                  60.h),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AddAgent.buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.fNameA,
                    fontSize: 12.sp,
                    maxLines: 1,
                  ),
                  Get.width / 2.5,
                  'Property Name *',
                  60.h),
              SizedBox(
                width: 20.w,
              ),
              AddAgent.buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.lNameA,
                    fontSize: 12.sp,
                    maxLines: 1,
                  ),
                  Get.width / 2.5,
                  'Property Cost *',
                  60.h),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AddAgent.buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.phoneNA,
                    fontSize: 12.sp,
                    maxLines: 1,
                  ),
                  // Get.width / 3.8,
                  Get.width / 5 - 10.w,
                  'Phone Number *',
                  60.h),
              SizedBox(
                width: 20.w,
              ),
              AddAgent.buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.positionA,
                    fontSize: 12.sp,
                    maxLines: 1,
                  ),
                  Get.width / 5 - 10.w,
                  'Position *',
                  60.h),
              SizedBox(
                width: 20.w,
              ),
              AddAgent.buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.passwordA,
                    fontSize: 12.sp,
                    maxLines: 1,
                  ),
                  Get.width / 5 - 10.w,
                  'Password *',
                  60.h),
              SizedBox(
                width: 20.w,
              ),
              AddAgent.buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.confirmPA,
                    fontSize: 12.sp,
                    maxLines: 1,
                  ),
                  Get.width / 5 - 10.w,
                  'Confirm Password *',
                  60.h),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AddAgent.buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.descriptionA,
                    fontSize: 12.sp,
                    maxLines: 50,
                  ),
                  Get.width / 1.2 - 45.w,
                  'Description *',
                  200.h),
            ],
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     AddAgent.buildTextFormField(
          //         TextformfieldWidget(
          //           controller: controller.descriptionA,
          //           fontSize: 12.sp,
          //           maxLines: 50,
          //         ),
          //         Get.width / 1.2 - 45.w,
          //         'Description *',
          //         200.h),
          //   ],
          // ),
          SizedBox(
            height: 10.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: 'Upload Photo *',
                fontSize: 18.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: Get.width / 1.2 - 45.w,
                height: 250.h,
                decoration: BoxDecoration(
                  color: AppColors.hint.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.hint.withOpacity(0.9),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Image.asset(AppEraAssets.uploadAdmin),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 80.w),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Button(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 150.w,
                height: 35.h,
                text: 'SUBMIT',
                bgColor: AppColors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              Button(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 150.w,
                height: 35.h,
                text: 'CANCEL',
                bgColor: AppColors.hint,
                borderRadius: BorderRadius.circular(30),
              ),
            ]),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  _error() {
    //todo add error screen
  }
  _empty() {
    //todo add empty screen
  }
}
