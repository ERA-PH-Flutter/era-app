import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/forms/contacts/controllers/contacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../app/constants/sized_box.dart';

class Inquiry extends GetView<ContactusController> {
  const Inquiry({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(21.w),
      child: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            EraText(
              text: 'Inquire now for details on availability and pricing',
              fontSize: 25.sp,
              color: AppColors.kRedColor,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                    text: 'FIRST NAME*',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
                SizedBox(height: 2.h),
                TextformfieldWidget(
                  hintText: 'Enter Your First Name',
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  controller: controller.fname,
                ),
                SizedBox(height: 5.h),
                EraText(
                  text: 'LAST NAME*',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: 2.h),
                TextformfieldWidget(
                  hintText: 'Enter Your Last Name',
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  controller: controller.lname,
                ),
                SizedBox(height: 5.h),
                EraText(
                  text: 'EMAIL*',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: 2.h),
                TextformfieldWidget(
                  hintText: 'Enter Email',
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.email,
                  validator: (value) {
                    if (!RegExp(
                            r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                        .hasMatch(value!)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5.h),
                EraText(
                  text: 'MOBILE NUMBER*',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: 2.h),
                TextformfieldWidget(
                  hintText: 'Enter Mobile Number',
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  controller: controller.mNumber,
                ),
                SizedBox(height: 5.h),
                EraText(
                  text: 'DESCRIPTION*',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: 2.h),
                TextformfieldWidget(
                  hintText: 'Enter Description',
                  maxLines: 12,
                  // keyboardType: TextInputType.text,
                  controller: controller.desc,
                  textInputAction: TextInputAction.newline,
                ),
                sb30(),
                Button.button2(Get.width, 48.h, () {
                  print('Send');
                  controller.sumbitInquire();
                }, 'Send'),
                sb10(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
