import 'package:architecture/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageViewer {
  CustomImageViewer._();

  static show(
      {required BuildContext context,
      required String url,
      BoxFit? fit,
      double? radius}) {
    return Container(
      // width: 500.w,
      height: 177.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 8),
        border: Border.all(
          color: AppColors.white,
          width: 2,
        ),
        image: DecorationImage(
          image: AssetImage(url),
          fit: fit ?? BoxFit.cover,
        ),
      ),
    );
  }
}
