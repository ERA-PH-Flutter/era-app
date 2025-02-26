// shared_widgets.dart
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';

class SharedWidgets {
  static Widget textFormfield({
    String? hintText,
    TextInputType? textInputType,
    String? name,
    TextEditingController? controller,
    int? MaxLines = 1,
    Function(String)? onChanged,
    String? Function(String?)? validator,
    String? labelText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(text: name ?? "", fontSize: 18.sp, color: AppColors.black),
        sb10(),
        TextFormField(
          validator: validator,
          onChanged: onChanged,
          maxLines: MaxLines,
          controller: controller,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                color: AppColors.hint,
                fontSize:
                    Theme.of(Get.context!).textTheme.bodyMedium?.fontSize),
            labelStyle: TextStyle(color: AppColors.hint),
            labelText: labelText,
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

  static Widget dropDown(RxnString selectedItem, List<String> Types,
      Function(String?) onChanged, String name, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(text: name, fontSize: 18.sp, color: AppColors.black),
        SizedBox(height: 5.h),
        Obx(
          () => DropdownButtonFormField<String>(
            alignment: Alignment.centerLeft,
            decoration: InputDecoration(
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
            focusColor: AppColors.white,
            value: selectedItem.value,
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            isExpanded: true,
            isDense: true,
            hint: Align(
              alignment: Alignment.centerLeft,
              child: EraText(
                text: hintText,
                textAlign: TextAlign.center,
                color: Colors.grey,
                fontSize: 20.sp,
              ),
            ),
            items: Types.map<DropdownMenuItem<String>>((String value) {
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

  static Widget dropDownListings(
      {RxnString? selectedItem,
      List<String>? Types,
      Function(String?)? onChanged,
      String? labelText,
      String? hintText}) {
    return Obx(
      () => DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: AppColors.hint,
              fontSize: Theme.of(Get.context!).textTheme.bodyMedium?.fontSize),
          labelText: labelText,
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
        value: selectedItem?.value,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        isExpanded: true,
        isDense: true,
        //  hintText: hintText,

        // hint: Align(
        //   alignment: Alignment.centerLeft,
        //   child: EraText(
        //     text: hintText!,
        //     textAlign: TextAlign.center,
        //     color: Colors.grey,
        //     fontSize: Theme.of(Get.context!).textTheme.bodyMedium?.fontSize,
        //   ),
        // ),
        items: Types!.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: EraText(
              text: value,
              color: AppColors.black,
              fontSize: Theme.of(Get.context!).textTheme.bodyMedium?.fontSize,
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  static Widget backgroundColumn() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black,
      ),
    );
  }
}
