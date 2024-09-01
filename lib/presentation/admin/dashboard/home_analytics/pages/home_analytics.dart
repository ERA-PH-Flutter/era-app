import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/dashboard/home_analytics/controllers/home_analytics_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//todo add text

// ignore: must_be_immutable
class HomeAnalytics extends GetView<HomeAController> {
  const HomeAnalytics({super.key});

  // AddListingsController controllers = Get.put(AddListingsController());

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextFormField(
                  TextformfieldWidget(
                    controller: controller.propertyNameController,
                    fontSize: 12.sp,
                    maxLines: 1,
                  ),
                  105.w,
                  'Property Name*',
                  60.h),
            ],
          ),
          SizedBox(
            width: 5.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
            ],
          ),
        ],
      ),
    ]);
  }

  Widget _buildTextFormField(
      Widget child, double width, String text, double height) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: height,
              width: width,
              child: child,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ],
    );
  }
}
