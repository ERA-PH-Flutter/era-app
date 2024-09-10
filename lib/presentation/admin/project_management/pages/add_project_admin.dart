import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/admin/project_management/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddProjectAdmin extends GetView<ListingsAdminController> {
  const AddProjectAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    AgentAdminController controller = Get.put(AgentAdminController());

    return SingleChildScrollView(
      child: Padding(
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
              text: 'ADD PROJECTS',
              color: AppColors.black,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.w600,
            ),
            EraText(
              text: 'BANNER PHOTO ',
              color: AppColors.black,
              fontSize: EraTheme.header - 10.sp,
              fontWeight: FontWeight.w600,
            ),
            AddAgent.buildUploadPhoto(onTap: () {
              controller.getImageGallery();
            }),
            SizedBox(height: 20.h),
            buildUploadSection(
              title: 'Upload Cover Photo *',
              controller1: controller.fNameA,
              text1: 'Property Name *',
              maxLines1: 3,
              controller2: controller.fNameA,
              text2: 'Description Title *',
              maxLines2: 3,
            ),
            SizedBox(height: 20.h),
            buildUploadSection(
              title: 'Upload Logo *',
              controller1: controller.fNameA,
              text1: 'Description *',
              maxLines1: 10,
            ),
            SizedBox(height: 20.h),
            buildUploadSection(
              title: 'Add Carousel Images *',
              controller1: controller.fNameA,
              text1: 'Carousel Title *',
              maxLines1: 3,
              controller2: controller.fNameA,
              text2: 'Carousel Footer',
              maxLines2: 3,
            ),
            SizedBox(height: 20.h),
            EraText(
              text: 'Description *',
              color: AppColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 10.h),
            buildTextFormField2(
              text: '',
              controller: controller.fNameA,
              maxLines: 10,
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Button(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 150.w,
                  text: 'SUBMIT',
                  bgColor: AppColors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                Button(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 150.w,
                  text: 'CANCEL',
                  bgColor: AppColors.hint,
                  borderRadius: BorderRadius.circular(30),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUploadSection({
    required String title,
    required TextEditingController controller1,
    required String text1,
    TextEditingController? controller2,
    String? text2,
    int maxLines1 = 1,
    int? maxLines2,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: title,
              color: AppColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 10.h),
            Container(
              height: 300.h,
              width: 500.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.hint,
              ),
            ),
          ],
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            children: [
              buildTextFormField2(
                text: text1,
                controller: controller1,
                maxLines: maxLines1,
              ),
              if (text2 != null && controller2 != null) ...[
                SizedBox(height: 20.h),
                buildTextFormField2(
                  text: text2,
                  controller: controller2,
                  maxLines: maxLines2 ?? 1,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  static Widget buildTextFormField2({
    required String text,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (text.isNotEmpty)
          EraText(
            text: text,
            fontSize: 18.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.black,
                width: 1.5,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
