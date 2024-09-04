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
  final void Function(String)? onChanged;

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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLines: maxLines ?? 18,
      controller: controller,
      obscureText: obscureText ?? false,
      validator: validator,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        // contentPadding: contentPadding ?? EdgeInsets.zero,
        suffixIcon: suffixIcon,

        hintText: hintText,
        hintStyle: hintstlye ??
            TextStyle(color: AppColors.hint, fontSize: fontSize ?? 18.sp),
        fillColor: AppColors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color ?? AppColors.black,
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
