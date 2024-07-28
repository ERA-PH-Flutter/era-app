import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextformfieldWidget extends StatelessWidget {
  final TextStyle? style;
  final String hintText;
  final TextStyle? hintstlye;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  const TextformfieldWidget({
    super.key,
    this.style,
    required this.hintText,
    this.hintstlye,
    this.controller,
    this.contentPadding,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 18,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            hintstlye ?? TextStyle(color: AppColors.hint, fontSize: 18.sp),
        fillColor: AppColors.white,
        filled: true,
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
    );
  }
}
