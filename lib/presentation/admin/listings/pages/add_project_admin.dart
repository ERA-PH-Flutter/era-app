import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/add-agent.dart';
import 'package:eraphilippines/presentation/admin/listings/controllers/listingsAdmin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddProjectAdmin extends GetView<ListingsAdminController> {
  const AddProjectAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    AgentAdminController controller = Get.put(AgentAdminController());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          EraText(
            text: 'PROPERTY INFORMATION',
            color: AppColors.black,
            fontSize: EraTheme.header,
            fontWeight: FontWeight.w500,
          ),
          EraText(
            text: 'CREATE LISTING',
            color: AppColors.black,
            fontSize: EraTheme.header,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                      text: ' Upload Cover Image',
                      color: AppColors.black,
                      fontSize: EraTheme.paragraph,
                      fontWeight: FontWeight.w500),
                  SizedBox(height: 10.h),
                  Container(
                    color: AppColors.blue,
                    height: 250.h,
                    width: 500.w,
                  ),
                ],
              ),
              SizedBox(width: 20.w),
              Column(
                children: [
                  buildTextFormField2('Property Name *', controller.fNameA),
                  buildTextFormField2('Property Name *', controller.fNameA),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildTextFormField2(
    String text,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: text,
          fontSize: 18.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 105.h,
          width: Get.width / 2.5,
          child: TextformfieldWidget(
            contentPadding: EdgeInsets.only(top: 30.h, bottom: 30.h),
            controller: controller,
            fontSize: 12.sp,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
