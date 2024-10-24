import 'dart:io';

import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/website/form/controllers/form_web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/constants/sized_box.dart';
import '../../../agent/forms/contacts/pages/findus.dart';
import '../../../agent/listings/add-edit_listings/pages/addlistings.dart';

class ContactUsWeb extends GetView<FormWebController> {
  const ContactUsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FormWebController());
    return Container(
      width: Get.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: "Contact Us",
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
              SizedBox(height: 20.h),
              contacts(),
              // Help.iconButton(
              //   padding: EdgeInsets.only(right: 10.w),
              //   icon: AppEraAssets.whatsappIcon,
              //   icon2: AppEraAssets.emailIcon,
              // ),
              FindUs(
                title: 'Find Us',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
            text: 'Name',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black),
        SizedBox(height: 5.h),
        TextformfieldWidget(
          hintText: 'Name',
          maxLines: 1,
          controller: controller.nameC,
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 20.h),
        EraText(
            text: 'Phone Number',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black),
        SizedBox(height: 5.h),
        TextformfieldWidget(
          controller: controller.numberC,
          hintText: '000-000-0000',
          maxLines: 1,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20.h),
        EraText(
            text: 'Email',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black),
        SizedBox(height: 5.h),
        TextformfieldWidget(
          controller: controller.emailAC,
          hintText: 'Your email here',
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
        ),
        sb20(),
        AddListings.dropDownAddlistings(
          selectedItem: controller.selectedSubj,
          Types: controller.subject,
          onChanged: (value) => controller.selectedSubj.value = value!,
          name: 'Subject Type',
          hintText: 'Select Subject Type',
          color: AppColors.black,
          padding: EdgeInsets.zero,
        ),
        EraText(
          text: 'Message',
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        TextformfieldWidget(
          controller: controller.messageC,
          hintText: 'Type your message here',
          maxLines: 15,
          color: AppColors.hint,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
        ),
        sb30(),
        Button.button2(
          Get.width,
          53.h,
          () async {
            await controller.submitContact();
          },
          'Send',
        ),
        sb30(),
      ],
    );
  }
}
