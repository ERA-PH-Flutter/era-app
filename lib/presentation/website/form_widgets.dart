import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/constants/colors.dart';
import '../../app/constants/theme.dart';

class BottomWidgets {
  static Widget bigCircle() {
    return Container(
      width: 30.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: const Color(0xFF0e6937),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check,
        color: AppColors.white,
      ),
    );
  }

  static Widget eraJoinTitle({
    required String text,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: EraTheme.paragraphWeb - 10.sp,
        color: AppColors.hint,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
