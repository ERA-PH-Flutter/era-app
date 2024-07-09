import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/assets.dart';
import '../constants/colors.dart';

class AppTextField extends StatelessWidget {
  final String? svgIcon;
  final String? hint;
  final Color? bgColor;
  final TextEditingController? controller;
  final double? height;
  final VoidCallback? onSuffixTap;
  final bool? isSuffix;
  final bool? isPrefix;
  final bool? isHint;
  final bool? obscureText;
  final Widget? countryPicker;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onObscure;
  final bool? isEnabled;
  final String? suffixIcons;
  final EdgeInsets? padding;
  final TextAlignVertical? alignVertical;
  final bool? expands;
  final void Function(String)? onChange;
  const AppTextField({
    super.key,
    this.controller,
    this.svgIcon,
    this.hint,
    this.height,
    this.onSuffixTap,
    this.isSuffix = false,
    this.bgColor,
    this.isPrefix = true,
    this.isHint = true,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.countryPicker,
    this.onObscure,
    this.isEnabled = true,
    this.suffixIcons,
    this.padding,
    this.alignVertical,
    this.expands,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h,
      child: CupertinoTextField(
        expands: expands ?? false,
        enabled: isEnabled!,
        onChanged: onChange ?? (string) {},
        inputFormatters: inputFormatters,
        textAlign: TextAlign.justify,
        textAlignVertical: alignVertical ?? TextAlignVertical.center,
        obscureText: obscureText!,
        textInputAction: textInputAction ?? TextInputAction.done,
        placeholderStyle: TextStyle(
          fontSize: 18.sp,
          color: AppColors.hint,
          height: 0.0,
          fontFamily:
              GoogleFonts.poppins(fontWeight: FontWeight.w500).fontFamily,
        ),
        suffix: isSuffix!
            ? GestureDetector(
                onTap: onObscure ?? () {},
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: GestureDetector(
                      onTap: onSuffixTap,
                      child: Image.asset(
                        suffixIcons ?? AppSvgAssets.hide,
                        height: 24.h,
                        color:
                            obscureText! ? AppColors.hint : AppColors.primary,
                      )),
                ),
              )
            : const SizedBox.shrink(),
        prefix: isPrefix!
            ? Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.w, 0, 7.5.w, 0),
                    child: Image.asset(
                      svgIcon ?? AppSvgAssets.person,
                      height: 24.h,
                    ),
                  ),
                  if (countryPicker != null) ...[countryPicker!]
                ],
              )
            : const SizedBox.shrink(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: bgColor ?? AppColors.textFieldBackground,
        ),
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        placeholder: !isHint! ? '' : hint ?? "John Doe",
        controller: controller,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.w),
        style:
            GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 17.sp),
      ),
    );
  }
}
