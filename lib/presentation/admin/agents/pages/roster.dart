import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/roster_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Roster extends GetView<AgentAdminController> {
  const Roster({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 70.w),
            child: EraText(
              text: 'AGENT CARD VIEW',
              color: AppColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 70.w),
            child: EraText(
              text: 'FIND AGENT',
              color: AppColors.kRedColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          buildField(),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: Get.width - 520.w),
            child: Button(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: 150.w,
              height: 35.h,
              text: 'SEARCH',
              fontSize: 15.sp,
              bgColor: AppColors.kRedColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          RosterGridview(listingModels: RealEstateListing.listingsModels),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget buildField() {
    return Column(
      children: [
        buildFormField('First Name *', controller.fNameA, 'Last Name *',
            controller.lNameA),
        buildFormField('Phone Number *', controller.phoneNA, 'Email *',
            controller.emailAdressA),
      ],
    );
  }

  Widget buildFormField(String name, TextEditingController controller,
      String name2, TextEditingController controller2) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: name,
                color: AppColors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: Get.width / 2.5,
                child: TextformfieldWidget(
                  controller: controller,
                  fontSize: 12.sp,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: name2,
                color: AppColors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: Get.width / 2.5,
                child: TextformfieldWidget(
                  controller: controller2,
                  fontSize: 12.sp,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
