import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentBorder extends StatelessWidget {
  final Widget? child;
  const AgentBorder({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 120.h, left: 50.w, right: 50.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.hint.withOpacity(0.5), width: 3),
          borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }
}
