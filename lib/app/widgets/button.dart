import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? bgColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextStyle? style;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  const Button({
    super.key,
    this.onTap,
    required this.text,
    this.bgColor,
    this.fontWeight,
    this.fontSize,
    this.style,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          margin: margin ?? EdgeInsets.symmetric(horizontal: 35),
          height: height ?? 50.h,
          width: width ?? 184.w,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            color: bgColor,
          ),
          child: Center(
              child: FarmerText(
            text: text,
            color: AppColors.white,
            fontSize: fontSize,
            fontWeight: fontWeight,
          )),
        ),
      ),
    );
  }
}
