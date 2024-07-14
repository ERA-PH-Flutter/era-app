import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImage extends StatelessWidget {
  final String url;
  final double? radius;
  // final bool isActive;
  //  required this.isActive;
  const CustomImage({
    super.key,
    required this.url,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.white,
          width: 1,
        ),
        // borderRadius: BorderRadius.circular(isActive ? (radius ?? 30) : 0),
      ),
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(isActive ? (radius ?? 30) : 0),
        child: Image.asset(
          url,
          fit: BoxFit.fill,
          width: 500.w,
          height: 500.h,
        ),
      ),
    );
  }
}
