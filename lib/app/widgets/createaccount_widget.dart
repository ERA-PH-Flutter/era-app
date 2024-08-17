// shared_widgets.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';

class SharedWidgets {
  static Widget textFormfield(String hintText, TextInputType? textInputType,
      String name, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(text: name, fontSize: 18.sp, color: AppColors.black),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.hint, fontSize: 18.sp),
            labelStyle: TextStyle(color: AppColors.hint),
            filled: false,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.hint),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.hint),
            ),
          ),
          keyboardType: textInputType ?? TextInputType.none,
        ),
      ],
    );
  }

  static Widget paddingText(String name, FontWeight fontWeight) {
    return Padding(
        padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 30.h),
        child: Row(
          children: [
            textBuild(name, 25.sp, fontWeight, AppColors.white),
            Spacer(),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(CupertinoIcons.arrow_left, color: AppColors.white)),
          ],
        ));
  }

  static Widget textBuild(
      String text, double fontSize, FontWeight fontWeight, Color color) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: EraText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        maxLines: 50,
      ),
    );
  }

  static Widget dropDown(RxnString selectedGender, List<String> genderType,
      Function(String?) onChanged, String name, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(text: name, fontSize: 18.sp, color: AppColors.black),
        SizedBox(height: 5.h),
        Obx(
          () => DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: AppColors.hint, fontSize: 18.sp),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.hint),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.hint),
              ),
            ),
            dropdownColor: AppColors.white,
            focusColor: AppColors.hint,
            value: selectedGender.value,
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: genderType.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: EraText(
                  text: value,
                  color: AppColors.black,
                  fontSize: 20.sp,
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  static Widget backgroundColumn() {
    return Column(
      children: [
        Container(
          height: Get.height / 7.h,
          decoration: BoxDecoration(
            color: AppColors.kRedColor,
          ),
        ),
        Container(
          height: Get.height - Get.height / 6.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
        ),
      ],
    );
  }
}
