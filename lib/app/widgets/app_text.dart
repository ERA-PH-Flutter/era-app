import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class EraText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? fontSize;
  final double? lineHeight;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecoration;
  final int? maxLines;
  final TextEditingController? controller;

  const EraText({
    required this.text,
    this.style,
    super.key,
    this.fontSize,
    this.lineHeight,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.textOverflow,
    this.textDecoration,
    this.maxLines,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines ?? 3,
      text,
      textAlign: textAlign,
      textScaler: TextScaler.linear( ScreenUtil().textScaleFactor),
      style: style ??
          TextStyle(
            decoration: textDecoration ?? TextDecoration.none,
            decorationColor: color ?? AppColors.white,
            fontFamily:
                GoogleFonts.lato(fontWeight: fontWeight ?? FontWeight.w500)
                    .fontFamily,
            fontSize: (fontSize ?? 13.sp) > 25.sp ? fontSize! - 4.sp : fontSize,
            fontWeight: fontWeight ?? FontWeight.w500,
            color: color ?? AppColors.white,
            overflow: textOverflow ?? TextOverflow.visible,
            height: lineHeight, //?? 1.19,
          ),
    );
  }
}
