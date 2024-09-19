import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextformfieldWidget extends StatelessWidget {
  final TextStyle? style;
  final String? hintText;
  final TextStyle? hintstlye;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final double? fontSize;
  final Color? color;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final double? radius;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputAction? textInputAction;
  final BorderSide? borderSide;
  final InputBorder? border;
  final InputBorder? enabledBorder;

  const TextformfieldWidget({
    super.key,
    this.style,
    this.hintText,
    this.hintstlye,
    this.controller,
    this.contentPadding,
    this.maxLines,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.fontSize,
    this.color,
    this.validator,
    this.readOnly,
    this.onChanged,
    this.onTap,
    this.radius,
    this.textInputAction,
    this.borderSide,
    this.border,
    this.enabledBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.multiline,
      maxLines: maxLines ?? 18,
      controller: controller,
      obscureText: obscureText ?? false,
      validator: validator,
      readOnly: readOnly ?? false,
      textInputAction: textInputAction ?? TextInputAction.none,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(top: 10.h, bottom: 0.h, left: 10.w, right: 0.w),
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintstlye ??
            TextStyle(color: AppColors.hint, fontSize: fontSize ?? 18.sp),
        fillColor: AppColors.white,
        filled: true,
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 10),
              borderSide: borderSide ??
                  BorderSide(
                    color: color ?? AppColors.black,
                    width: 1.5,
                  ),
            ),
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 10),
            ),
      ),
    );
  }
}
