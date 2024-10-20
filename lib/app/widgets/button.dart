import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/theme.dart';

class Button extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final Color? bgColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextStyle? style;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Color? color;

  const Button({
    super.key,
    this.onTap,
    this.text,
    this.bgColor,
    this.fontWeight,
    this.fontSize,
    this.style,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.borderRadius,
    this.border,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          margin: margin ?? EdgeInsets.zero,
          height: height ?? EraTheme.buttonHeightSmall,
          width: width ?? Get.width - 220.w,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            color: bgColor,
            border: border ?? Border.all(color: Colors.transparent),
          ),
          child: Center(
              child: EraText(
            text: text ?? '',
            color: color ?? AppColors.white,
            fontSize: fontSize ?? 15.sp,
            fontWeight: fontWeight,
          )),
        ),
      ),
    );
  }

  static Widget button2(
    double width,
    double height,
    Function() onTap,
    String text,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: EraTheme.buttonHeightSmall,
        width: width, //272.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.kRedColor,
        ),
        child: Center(
            child: EraText(
          text: text,
          color: AppColors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        )),
      ),
    );
  }

  static Widget button3(
      double width, double height, Function() onTap, String text, Color color,
      {fontSize, fontWeight}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width, //272.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        child: Center(
            child: EraText(
          text: text,
          color: AppColors.white,
          fontSize: fontSize ?? 20.sp,
          fontWeight: fontWeight ?? FontWeight.w500,
        )),
      ),
    );
  }
}
