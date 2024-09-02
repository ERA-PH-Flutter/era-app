import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final void Function()? onPressed;
  final FocusNode? onFocused;
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
    this.onPressed,
    this.onFocused,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 43.h,
      child: CupertinoTextField(
        focusNode: onFocused,
        onTap: onPressed,
        expands: expands ?? false,
        enabled: isEnabled!,
        onChanged: onChange ?? (string) {},
        inputFormatters: inputFormatters,
        textAlign: TextAlign.justify,
        textAlignVertical: alignVertical ?? TextAlignVertical.center,
        obscureText: obscureText!,
        textInputAction: textInputAction ?? TextInputAction.done,
        placeholderStyle: TextStyle(
          fontSize: 20.sp,
          color: AppColors.hint,
          height: 0.0,
          fontFamily:
              GoogleFonts.montserrat(fontWeight: FontWeight.w400).fontFamily,
        ),
        suffix: isSuffix!
            ? GestureDetector(
                onTap: onObscure ?? () {},
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 20.w,
                  ),
                  child: GestureDetector(
                      onTap: onSuffixTap,
                      child: Image.asset(
                        suffixIcons ?? AppEraAssets.hide,
                        height: 30.h,
                        color: obscureText!
                            ? AppColors.primary
                            : AppColors.kRedColor,
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
                      svgIcon ?? AppEraAssets.person,
                      height: 30.h,
                      color: AppColors.kRedColor,
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
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400, fontSize: 20.sp),
      ),
    );
  }
}
